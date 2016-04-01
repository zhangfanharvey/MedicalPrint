//
//  ClassDetailController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "ClassDetailController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"

@interface ClassDetailController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *participantsLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *applyButton;

@end

@implementation ClassDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel = [[UILabel alloc] init];
    [self.view addSubview:self.titleLabel];
    
    self.containerView = [[UIView alloc] init];
    [self.view addSubview:self.containerView];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.view addSubview:self.timeLabel];
    
    self.locationLabel = [[UILabel alloc] init];
    [self.view addSubview:self.locationLabel];
    
    self.participantsLabel = [[UILabel alloc] init];
    [self.view addSubview:self.participantsLabel];
    
    self.lineImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.lineImageView];
    
    self.textView = [[UITextView alloc] init];
    [self.view addSubview:self.textView];
    
    self.applyButton = [[UIButton alloc] init];
    [self.view addSubview:self.applyButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewConstraints {
    UIView *superView = self.view;
    CGFloat gap = 15;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(superView.mas_top).offset(5);
        make.right.equalTo(superView.mas_right).offset(-gap);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.participantsLabel.mas_left).offset(10);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
    }];
    
    [self.participantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.locationLabel.mas_top);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.applyButton.mas_top);
    }];
    
    [self.applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView);
        make.height.equalTo(@45);
    }];
}


@end
