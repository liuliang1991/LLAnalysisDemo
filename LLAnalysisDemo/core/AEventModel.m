//
//  AEventModel.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "AEventModel.h"

@implementation AEventModel

- (NSString *)description{
    return [NSString stringWithFormat:@"type:%ld, eventId:%ld, eventName:%@, time:%@", self.eventType, self.eventId,self.eventName,self.timestamp];
}

@end
