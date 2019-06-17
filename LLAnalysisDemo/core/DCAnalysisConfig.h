//
//  DCAnalysisConfig.h
//  LLAnalysisDemo
//
//  Created by liuliang on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AEventModel;

NS_ASSUME_NONNULL_BEGIN

@interface DCAnalysisConfig : NSObject

+ (NSDictionary *)getConfig;

+ (AEventModel *)viewDidLoadFromPage:(UIViewController *)page;

+ (AEventModel *)selectTable:(UITableView *)table atIndexPath:(NSIndexPath *)indexPath tableDelegate:(id)tableDelegate;

+ (AEventModel *)clickButton:(UIButton *)button target:(id)target action:(SEL)action;

+ (AEventModel *)tapView:(UIView *)view targetClassStr:(NSString *)targetStr actionStr:(NSString *)actionStr;

@end

NS_ASSUME_NONNULL_END
