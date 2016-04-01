//
//  FeedbackViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "FeedbackViewController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"

@interface FeedbackViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *commitButton;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView = [[UITextView alloc] init];
    [self.view addSubview:self.textView];
    
    self.commitButton = [[UIButton alloc] init];
    [self.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commitButton];
    
    [self initNaviBarItem];
    
    [self setupViewConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"意见反馈";
}

- (void)setupViewConstraints {
    UIView *superView = self.view;
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 15, 80, 15);
    CGFloat gap = 15;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.and.right.equalTo(superView).insets(insets);
        make.edges.equalTo(superView).insets(insets);
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@45);
    }];
}


#pragma mark - IBAction

- (IBAction)commitButtonClicked:(id)sender {
    if (self.textView.text.length > 0) {
        [self showLoadingWithText:@"加载中..."];
        [UserInfoRequest sendFeedbackWithConten:self.textView.text success:^(BOOL status) {
            [self hideLoadingView];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:msg];
        }];
    }
}

@end
