//
//  ViewController.m
//  spotlightDemo
//
//  Created by Zeus on 2018/5/29.
//  Copyright © 2018年 Zeus. All rights reserved.
//

#import "ViewController.h"
#import "MessageManager.h"
#import "MMessage.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnGet;

@property (nonatomic, strong) UITableView *tvList;

@property (nonatomic, copy) NSArray *listArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

#pragma mark -- setUI method
- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btnGet];
    self.btnGet.frame = CGRectMake(100, 100, 150, 50);
    
    [self.view addSubview:self.tvList];
    self.tvList.frame = self.view.bounds;
    self.tvList.hidden = YES;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpotlightTableViewCell" forIndexPath:indexPath];
    
    MMessage *mod = self.listArr[indexPath.row];
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.text = mod.title;
    lblTitle.font = [UIFont systemFontOfSize:20.0];
    lblTitle.textAlignment =NSTextAlignmentCenter;
    
    [cell.contentView addSubview:lblTitle];
    lblTitle.frame = cell.contentView.bounds;
    
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.messageMod = self.listArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark -- event method
- (void)getSaveData {
    
    [MessageManager getDataToSpotlightCompletion:^(NSArray *dataArr) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if (dataArr.count == 0) {
                self.tvList.hidden = YES;
            }else {
                self.btnGet.hidden = YES;
                self.tvList.hidden = NO;
                
                self.listArr = dataArr;
                [self.tvList reloadData];
            }
        });
        
    }];
}

- (void)restoreUserActivityState:(NSUserActivity *)activity{
    
    NSString *idetifier = activity.userInfo[@"kCSSearchableItemActivityIdentifier"];
    
    for (MMessage *mod in self.listArr) {
        if ([mod.messageId isEqualToString:idetifier]) {
            DetailViewController *detailVC = [[DetailViewController alloc] init];
            detailVC.messageMod = mod;
            [self.navigationController pushViewController:detailVC animated:YES];
            break;
        }
    }
    
    
}

#pragma mark -- setter and getter method
- (UIButton *)btnGet {
    if (_btnGet == nil) {
        _btnGet = [[UIButton alloc] init];
        [_btnGet setTitle:@"从网络获取数据" forState:UIControlStateNormal];
        [_btnGet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnGet.backgroundColor = [UIColor blackColor];
        [_btnGet addTarget:self action:@selector(getSaveData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnGet;
}

- (UITableView *)tvList {
    if (_tvList == nil) {
        _tvList = [[UITableView alloc] init];
        _tvList.delegate = self;
        _tvList.dataSource = self;
        [_tvList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SpotlightTableViewCell"];
    }
    return _tvList;
}

@end
