//
//  UITableView+DCAnalysis.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UITableView+DCAnalysis.h"
#import "NSObject+LLHook.h"
#import "DCAnalysisConfig.h"
#import "DCAnalysisService.h"
@implementation UITableView (DCAnalysis)

+ (void)initialize
{
    if (self == [UITableView class]) {
        [self swizzleInstanceMethod:@selector(setDelegate:) with:@selector(ll_hook_setDelegate:)];
    }
}

-(void)ll_hook_setDelegate:(id<UITableViewDelegate>)delegate{
    [NSObject hook_methodWithOriginalClass:[delegate class]
                               originalSel:@selector(tableView:didSelectRowAtIndexPath:)
                             replacedClass:[self class]
                               replacedSel:@selector(ll_hook_tableView:didSelectRowAtIndexPath:)
                                    addSel:@selector(ll_add_tableView:didSelectRowAtIndexPath:)];
     [self ll_hook_setDelegate:delegate];
}

- (void)ll_hook_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AEventModel *model = [DCAnalysisConfig selectTable:tableView atIndexPath:indexPath tableDelegate:tableView.delegate];
    if(model){
        [DCAnalysisService insertDataWithModel:model];
    }
    [self ll_hook_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)ll_add_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
