//
//  UIGestureRecognizer+DCAnalysis.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIGestureRecognizer+DCAnalysis.h"
#import "NSObject+LLHook.h"
#import "DCAnalysisConfig.h"
#import "DCAnalysisService.h"
#import <objc/runtime.h>
@implementation UIGestureRecognizer (DCAnalysis)

static const char kTargetKey = '\0';
static const char kActionKey = '\0';
static const char kOriginActionKey = '\0';
- (void)setMyTargetStr:(NSString *)myTargetStr{
    objc_setAssociatedObject(self, &kTargetKey,
                             myTargetStr, OBJC_ASSOCIATION_COPY);
}
- (id)myTargetStr{
    return objc_getAssociatedObject(self, &kTargetKey);
}

- (void)setMyActionStr:(id)myActionStr{
    objc_setAssociatedObject(self, &kActionKey,myActionStr, OBJC_ASSOCIATION_COPY);
}
- (id)myActionStr{
    return objc_getAssociatedObject(self, &kActionKey);
}

- (void)setOroginActionStr:(id)originActionStr{
    objc_setAssociatedObject(self, &kOriginActionKey,originActionStr, OBJC_ASSOCIATION_COPY);
}
- (id)originActionStr{
    return objc_getAssociatedObject(self, &kOriginActionKey);
}


+ (void)initialize{
    //这里只处理点击手势
    if (self == [UITapGestureRecognizer class]) {
        [self swizzleInstanceMethod:@selector(initWithTarget:action:) with:@selector(ll_hook_initWithTarget:action:)];
    }
}

- (instancetype)ll_hook_initWithTarget:(id)target action:(SEL)action{
    UIGestureRecognizer *ges = [self ll_hook_initWithTarget:target action:action];
    if(!target || !action){
        return ges;
    }
    NSString * sel_name = [NSString stringWithFormat:@"%s/%@", class_getName([target class]),NSStringFromSelector(action)];
    SEL swizzledSEL =  NSSelectorFromString(sel_name);
     Method replacedMethod = class_getInstanceMethod([self class], @selector(hook_action:));
     BOOL addMethod = class_addMethod([target class], swizzledSEL, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if(addMethod){
        [[target class] swizzleInstanceMethod:action with:swizzledSEL];
    }
    [ges setOroginActionStr:NSStringFromSelector(action)];
    [ges setMyActionStr:sel_name];
    [ges setMyTargetStr:NSStringFromClass([target class])];
   return ges;
}

- (void)hook_action:(UIGestureRecognizer *)ges{
    AEventModel *model = [DCAnalysisConfig tapView:ges.view targetClassStr:[ges myTargetStr] actionStr:[ges originActionStr]];
    if(model){
        [DCAnalysisService insertDataWithModel:model];
    }
    SEL sel = NSSelectorFromString([ges myActionStr]);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, sel,ges);
    }
}



@end
