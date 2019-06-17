//
//  UIViewController+DCAnalysis.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIViewController+DCAnalysis.h"
#import "NSObject+LLHook.h"
#import "DCAnalysisConfig.h"
#import "DCAnalysisService.h"
@implementation UIViewController (DCAnalysis)

+ (void)initialize{
    if (self == [UIViewController class]) {
        [self swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(ll_hook_viewDidLoad)];
    }
}

- (void)ll_hook_viewDidLoad{
    [self ll_hook_viewDidLoad];
    AEventModel *model = [DCAnalysisConfig viewDidLoadFromPage:self];
    if(model){
        [DCAnalysisService insertDataWithModel:model];
    }
}


@end
