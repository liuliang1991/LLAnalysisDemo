//
//  DCAnalysisDao.h
//  ProjectDemo
//
//  Created by liuliang on 2019/6/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AEventModel;
@interface DCAnalysisDao : NSObject

- (BOOL)insertDataWithModel:(AEventModel *)model atTable:(NSString *)table;

- (NSArray *)selectAllDataAtTable:(NSString *)table;

- (BOOL)createTable:(NSString *)table;

- (BOOL)dropTable:(NSString *)table;

- (NSArray *)getDBTables;

@end

NS_ASSUME_NONNULL_END
