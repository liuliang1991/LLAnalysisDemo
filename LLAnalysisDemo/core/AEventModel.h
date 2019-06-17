//
//  AEventModel.h
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AEventModel : NSObject
//(0.pageview 1.action)
@property (nonatomic, assign) NSInteger eventType;
@property (nonatomic, assign) NSInteger eventId;
@property (nonatomic, copy  ) NSString *eventName;
@property (nonatomic, copy  ) NSString *timestamp;
@end

NS_ASSUME_NONNULL_END
