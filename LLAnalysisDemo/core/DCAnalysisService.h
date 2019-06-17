//
//  DCAnalysisService.h
//  ProjectDemo
//
//  Created by liuliang on 2019/6/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AEventModel;
@interface DCAnalysisService : NSObject

+ (void)uploadDataToServer;

+ (void)insertDataWithModel:(AEventModel *)model;

@end

NS_ASSUME_NONNULL_END
