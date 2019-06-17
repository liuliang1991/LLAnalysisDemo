//
//  DemosListVC.m
//  LLAnalysisDemo
//
//  Created by liuliang on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DemosListVC.h"

@interface DemosListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArrayM;

@end

@implementation DemosListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demos";
    [self.view addSubview:self.tableView];

    self.dataArrayM = @[@{@"title" : @"Page1", @"vc" :@"LLTestViewController1"},
                        @{@"title" : @"Page2", @"vc" : @"LLTestViewController2"},
                        @{@"title" : @"Page3", @"vc" : @"LLTestViewController3"},
                        @{@"title" : @"Page4", @"vc" : @"LLTestViewController4"},
                        ].mutableCopy;
}


#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArrayM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary *dict = self.dataArrayM[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataArrayM[indexPath.row];
    NSString *title = dict[@"title"];
   
    UIViewController *vc = [NSClassFromString(dict[@"vc"]) new];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


@end
