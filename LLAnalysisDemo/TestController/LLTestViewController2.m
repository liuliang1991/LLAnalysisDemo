//
//  LLTestViewController2.m
//  LLAnalysisDemo
//
//  Created by liuliang on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "LLTestViewController2.h"
#import "Masonry.h"
#import "UIView+TapGesture.h"
@interface LLTestViewController2 ()
@property (nonatomic, strong) UIView *tapView;
@property (nonatomic, strong) UIView *tapView1;
@end

@implementation LLTestViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tapView];
    [self.tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100.0);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100.0, 100.0));
    }];
    [self.tapView addTarget:self action:@selector(tap1)];
    
    [self.view addSubview:self.tapView1];
    [self.tapView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100.0, 100.0));
        make.top.equalTo(self.tapView.mas_bottom).offset(20.0);
    }];
    [self.tapView1 addTarget:self action:@selector(tap2)];
}

- (void)tap1{
    NSLog(@"tap view1 ....");
}

- (void)tap2{
    NSLog(@"tap view2 ....");
}

- (UIView *)tapView{
    if(!_tapView){
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor orangeColor];
        _tapView = view;
    }
    return _tapView;
}

- (UIView *)tapView1{
    if(!_tapView1){
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        _tapView1 = view;
    }
    return _tapView1;
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
