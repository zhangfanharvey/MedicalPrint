//
//  ClassDetailController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "CourseDetailController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "Course.h"

@interface CourseDetailController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *participantsLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *applyButton;

@property (nonatomic, strong) Course *course;

@end

@implementation CourseDetailController

- (instancetype)initWithCourse:(Course *)course {
    self = [self init];
    if (self) {
        self.course = course;
    }
    return self;
}

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
    [self.applyButton addTarget:self action:@selector(applyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.applyButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.applyButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.applyButton setTitle:@"在线报名" forState:UIControlStateNormal];

    [self.view addSubview:self.applyButton];
    
    [self setupViewConstraints];
    
    [self initNaviBarItem];
    
    [self initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Auto-Layout

- (void)setupViewConstraints {
    UIView *superView = self.view;
    CGFloat gap = 15;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(self.mas_topLayoutGuide).offset(5);
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


#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"培训课程";
}

- (void)initDataSource {
    if (self.course) {
        self.titleLabel.text = self.course.title;
//        self.timeLabel.text = self.course.startTime;
//        self.locationLabel.text = self.course.endTime;
        self.textView.text = self.course.content;
    }
}

#pragma mark - IBAction

- (IBAction)applyButtonClicked:(id)sender {
    [self showLoadingWithText:@"加载中..."];
    [UserInfoRequest addMeToMemberOfCourse:self.course success:^(BOOL status) {
        [self hideLoadingViewWithSuccess:@"申请成功"];
        self.applyButton.enabled = NO;
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"申请失败"];
    }];
}

@end
