//
//  DCAnalysisConfig.m
//  LLAnalysisDemo
//
//  Created by liuliang on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DCAnalysisConfig.h"
#import "AEventModel.h"
#import "YYModel.h"

NSDictionary *_configDic;
@implementation DCAnalysisConfig

+ (NSDictionary *)readConfig{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DCAnalysis" ofType:@"json"]];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if(obj && [obj isKindOfClass:[NSDictionary class]]){
        return obj;
    }
    return @{};
}

+ (NSDictionary *)getConfig{
    if(!_configDic){
        _configDic = [self readConfig];
    }
    return _configDic;
}

+ (NSDictionary *)getPVConfig{
    NSDictionary *config = [self getConfig];
    id pv = [config objectForKey:@"PAGEVIEW"];
    if(pv && [pv isKindOfClass:[NSDictionary class]]){
        return pv;
    }
    return @{};
}

+ (NSDictionary *)getActionConfig{
    NSDictionary *config = [self getConfig];
    id pv = [config objectForKey:@"ACTION"];
    if(pv && [pv isKindOfClass:[NSDictionary class]]){
        return pv;
    }
    return @{};
}


+ (AEventModel *)viewDidLoadFromPage:(UIViewController *)page{
    NSString *path = [NSString stringWithFormat:@"%@/viewDidLoad",[page class]];
    NSDictionary *pvConfig = [self getPVConfig];
    NSDictionary *modelDic = [pvConfig objectForKey:path];
    if(modelDic && [modelDic isKindOfClass:[NSDictionary class]]){
        return [AEventModel yy_modelWithDictionary:modelDic];
    }
    return nil;
}

+ (AEventModel *)selectTable:(UITableView *)table atIndexPath:(NSIndexPath *)indexPath tableDelegate:(id)tableDelegate{
    NSString *path = [NSString stringWithFormat:@"%@/tableTag%ld/section%ld/row%ld",[tableDelegate class],table.tag,indexPath.section,indexPath.row];
    NSDictionary *actionsDic = [self getActionConfig];
    NSDictionary *modelDic = [actionsDic objectForKey:path];
    if(modelDic && [modelDic isKindOfClass:[NSDictionary class]]){
        return [AEventModel yy_modelWithDictionary:modelDic];
    }
    return nil;
}

+ (AEventModel *)clickButton:(UIButton *)button target:(id)target action:(SEL)action{
    NSString *path = [NSString stringWithFormat:@"%@/buttonTag%ld/%@",[target class],button.tag,NSStringFromSelector(action)];
    NSDictionary *actionsDic = [self getActionConfig];
    NSDictionary *modelDic = [actionsDic objectForKey:path];
    if(modelDic && [modelDic isKindOfClass:[NSDictionary class]]){
        return [AEventModel yy_modelWithDictionary:modelDic];
    }
    return nil;
}

+ (AEventModel *)tapView:(UIView *)view targetClassStr:(NSString *)targetStr actionStr:(NSString *)actionStr{
    NSString *path = [NSString stringWithFormat:@"%@/viewTag%ld/%@",targetStr,view.tag,actionStr];
    NSDictionary *actionsDic = [self getActionConfig];
    NSDictionary *modelDic = [actionsDic objectForKey:path];
    if(modelDic && [modelDic isKindOfClass:[NSDictionary class]]){
        return [AEventModel yy_modelWithDictionary:modelDic];
    }
    return nil;
}


@end
