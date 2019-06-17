//
//  DCAnalysisDao.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DCAnalysisDao.h"
#import "FMDB.h"
#import "AEventModel.h"
@interface DCAnalysisDao ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end

#define kAnalysis_db  @"ll_analysis.db"

@implementation DCAnalysisDao

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)getDBPath{
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if(!dirs || !dirs.count){
        return nil;
    }
    NSString *docPath = [dirs firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:kAnalysis_db];
//    NSLog(@"analysis db path: %@",filePath);
    return filePath;
}

#pragma mark --- oc_db_connect
- (BOOL)insertDataWithModel:(AEventModel *)model atTable:(NSString *)table{
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@(event_type,event_id,event_name,timestamp) VALUES(?,?,?,?);",table];
        result = [db executeUpdate:sqlStr,@(model.eventType),@(model.eventId),model.eventName,model.timestamp];
        if (!result) {
            NSLog(@"insert data error --> <%@>",model);
        }else{
            NSLog(@"insert data success --><%@>",model);
        }
    }];
    return result;
}

- (NSArray *)selectAllDataAtTable:(NSString *)table{
    __block NSArray *arr = nil;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT event_type as eventType,event_id as eventId,event_name as eventName,timestamp FROM %@ ;",table];
        FMResultSet *set = [db executeQuery:sqlStr];
        if (!set) {
            NSLog(@"select all data error at table-->%@",table);
        }else{
            NSMutableArray *array = [NSMutableArray array];
            while ([set next]) {
                NSDictionary *dic = [set resultDictionary];
                [array addObject:dic];
            }
            arr = array;
        }
    }];
    return arr;
}

- (BOOL)createTable:(NSString *)table{
    __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        result = [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT,event_type INTEGER NOT NULL, event_id INTEGER NOT NULL, event_name TEXT NOT NULL, timestamp TEXT NOT NULL UNIQUE);",table]];
        if(!result){
            NSLog(@"create table fail --> %@",table);
        }else{
            NSLog(@"create table success --> %@",table);
        }
    }];
    return result;
}

- (BOOL)dropTable:(NSString *)table{
     __block BOOL result = YES;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE %@;",table];
        BOOL result = [db executeUpdate:sqlStr];
        if (!result) {
            NSLog(@"drop table error -->%@",table);
        }else{
            NSLog(@"drop table success -->%@",table);
        }
    }];
    return result;
}

- (NSArray *)getDBTables{
    __block NSArray *tables = nil;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"];
        FMResultSet *set = [db executeQuery:sqlStr];
        if (set) {
            NSMutableArray *array = [NSMutableArray array];
            while ([set next]) {
                NSDictionary *dic = [set resultDictionary];
                NSString *tableName = [dic objectForKey:@"name"];
                if(tableName){
                    [array addObject:dic[@"name"]];
                }
            }
            tables = array;
        }
    }];
    return tables;
}


#pragma mark --- lazy getter
- (FMDatabaseQueue *)dbQueue{
    if(!_dbQueue){
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[self getDBPath]];
    }
    return _dbQueue;
}


@end




