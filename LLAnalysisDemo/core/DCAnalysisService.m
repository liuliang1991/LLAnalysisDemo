//
//  DCAnalysisService.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DCAnalysisService.h"
#import "DCAnalysisDao.h"
#import "AEventModel.h"

@interface DCAnalysisService ()
@property (nonatomic, strong) DCAnalysisDao *dao;
@property (nonatomic, strong) NSArray *oldTables;
@end

static NSString *_table;

#define kAnalysis_table_prefix  @"analysis_"

@implementation DCAnalysisService

- (instancetype)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            self.oldTables = [self.dao getDBTables];
            NSLog(@"analysis.db all tables --> %@",self.oldTables);
            _table = [NSString stringWithFormat:@"%@%@",kAnalysis_table_prefix,[[self class] getTimestamp]];
            [self.dao createTable:_table];
        });
    }
    return self;
}

+ (void)uploadDataToServer{
    [[DCAnalysisService new] uploadOldDataToServer];
}

+ (void)insertDataWithModel:(AEventModel *)model{
    model.timestamp = [self getTimestamp];
    [[DCAnalysisService new] insertDataWithModel:model];
}

- (void)uploadOldDataToServer{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSString *table in self.oldTables) {
            if([table containsString:kAnalysis_table_prefix]){
                NSArray *tableData = [self.dao selectAllDataAtTable:table];
                NSLog(@"%@ all data --> %@",table,tableData);
                if(tableData && tableData.count){
                    //模拟网络请求
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        NSLog(@"table %@ data upload success ...",table);
                        [self.dao dropTable:table];
                    });
                }else{
                    [self.dao dropTable:table];
                }
            }
        }
    });
}

- (void)insertDataWithModel:(AEventModel *)model{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.dao insertDataWithModel:model atTable:_table];
    });
}


- (DCAnalysisDao *)dao{
    if(!_dao){
        _dao = [DCAnalysisDao new];
    }
    return _dao;
}


+ (NSString *)getTimestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeStamp = [NSString stringWithFormat:@"%.f", time*1000];
    return timeStamp;
}


@end
