//
//  UIControl+DCAnalysis.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIControl+DCAnalysis.h"
#import "NSObject+LLHook.h"
#import "DCAnalysisConfig.h"
#import "DCAnalysisService.h"
@implementation UIControl (DCAnalysis)

+ (void)initialize
{
    if (self == [UIControl class]) {
        [self swizzleInstanceMethod:@selector(sendAction:to:forEvent:) with:@selector(ll_hook_sendAction:to:forEvent:)];
    }
}

- (void)ll_hook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self ll_hook_sendAction:action to:target forEvent:event];
    //处理button 按钮
    if([self isKindOfClass:[UIButton class]]){
        AEventModel *model = [DCAnalysisConfig clickButton:(UIButton *)self target:target action:action];
        if(model){
            [DCAnalysisService insertDataWithModel:model];
        }
    }
}

@end
