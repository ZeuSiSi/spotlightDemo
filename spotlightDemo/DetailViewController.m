//
//  DetailViewController.m
//  spotlightDemo
//
//  Created by Zeus on 2018/5/29.
//  Copyright © 2018年 Zeus. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UIImageView *imgvIcon;

@property (nonatomic, strong) UILabel *lblTitle;

@property (nonatomic, strong) UILabel *lblContent;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

#pragma mark -- setUI
- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imgvIcon];
    self.imgvIcon.frame = CGRectMake(100, 100, 200, 200);
    
    [self.view addSubview:self.lblTitle];
    self.lblTitle.frame = CGRectMake(100, 330, 200, 30);
    
    [self.view addSubview:self.lblContent];
    self.lblContent.frame = CGRectMake(100, 350, 200, 300);
}

#pragma mark -- setter and getter method
- (void)setMessageMod:(MMessage *)messageMod {
    _messageMod = messageMod;
    
    self.imgvIcon.image = [UIImage imageNamed:messageMod.icon];
    self.lblTitle.text = messageMod.title;
    self.lblContent.text = messageMod.content;
}

- (UIImageView *)imgvIcon {
    if (_imgvIcon == nil) {
        _imgvIcon = [[UIImageView alloc] init];
    }
    return _imgvIcon;
}

- (UILabel *)lblTitle {
    if (_lblTitle == nil) {
        _lblTitle = [[UILabel alloc] init];
        _lblTitle.font = [UIFont systemFontOfSize:20];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lblTitle;
}

- (UILabel *)lblContent {
    if (_lblContent == nil) {
        _lblContent = [[UILabel alloc] init];
        _lblContent.textAlignment = NSTextAlignmentCenter;
        _lblContent.font = [UIFont systemFontOfSize:15];
        _lblContent.numberOfLines = 0;
    }
    return _lblContent;
}

@end
