//
//  LLTestViewController1.m
//  LLAnalysisDemo
//
//  Created by liuliang on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "LLTestViewController1.h"
#import "Masonry.h"
@interface LLTestViewController1 ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *button1;
@end

@implementation LLTestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];;
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0, 40.0));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100.0);
    }];
    [self.button addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button1];;
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100.0, 40.0));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.button.mas_bottom).offset(20.0);
    }];
    [self.button1 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click1{
    NSLog(@"click  1111 ... ");
}

- (void)click2{
    NSLog(@"click 2222 ... ");
}


- (UIButton *)button{
    if(!_button){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"click" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        _button = button;
    }
    return _button;
}

- (UIButton *)button1{
    if(!_button1){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"click" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor redColor];
        _button1 = button;
    }
    return _button1;
}

- (void)dealloc{
    NSLog(@"delloc：%@",NSStringFromClass([self class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
