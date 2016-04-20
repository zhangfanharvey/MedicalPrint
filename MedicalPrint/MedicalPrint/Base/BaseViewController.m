//
//  BaseViewController.m
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "Masonry.h"
#import "HomeViewController.h"
#import "MedicalHelpController.h"
#import "Print3DController.h"
#import "SettingsViewController.h"
#import "UserPersonalCenterController.h"
#import "Masonry.h"


@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UILabel *noResultLabel;

@end

@implementation BaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!([self isKindOfClass:[HomeViewController class]] || [self isKindOfClass:[MedicalHelpController class]] || [self isKindOfClass:[Print3DController class]] || [self isKindOfClass:[SettingsViewController class]] || [self isKindOfClass:[UserPersonalCenterController class]])) {
            self.hidesBottomBarWhenPushed = YES;
            [self initNavBarButtonItemWithImages:@[@"顶部撤回键"] action:@selector(backButtonClicked:) isLeft:YES];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];(
    self.navigationController.navigationBar.barStyle = (UIBarStyle)[self preferredStatusBarStyle]);
    
//    [self initNavBarButtonItemWithImages:@[@"顶部撤回键"] action:@selector(backButtonClicked:) isLeft:YES];
}

#pragma mark - Navigation Bar methods

- (void)initNavBarButtonItemWithImages:(NSArray *)imagesArray action:(SEL)selector isLeft:(BOOL)isLeft
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imagesArray && imagesArray.count > 0) {
        UIImage *image = [UIImage imageNamed:[imagesArray objectAtIndex:0]];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    }
    if (imagesArray && imagesArray.count > 1) {
        [button setImage:[UIImage imageNamed:[imagesArray objectAtIndex:1]] forState:UIControlStateHighlighted];
    }
    if (imagesArray && imagesArray.count > 2) {
        [button setImage:[UIImage imageNamed:[imagesArray objectAtIndex:2]] forState:UIControlStateDisabled];
    }
    if (selector) {
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    else {
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -9);
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}

- (void)initNavBarButtonItemWithTitle:(NSString *)title action:(SEL)selector isLeft:(BOOL)isLeft
{
    [self initNavBarButtonItemWithTitle:title action:selector isLeft:isLeft textColor:nil];
}

- (void)initNavBarButtonItemWithTitle:(NSString *)title action:(SEL)selector isLeft:(BOOL)isLeft textColor:(UIColor *)textColor
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    else {
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
    if (textColor) {
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                        textColor,
                                                                        NSForegroundColorAttributeName,
                                                                        nil] forState:UIControlStateNormal];
//        [self.navigationItem.rightBarButtonItem setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                                                         [YNTheme defaultNavItemDisEnabledColor],
//                                                                         NSForegroundColorAttributeName,
//                                                                         nil] forState:UIControlStateDisabled];
    }
}

#pragma mark - loading
- (void)showLoadingWithText:(NSString *)text {
    [self showLoadingWithText:text toView:self.view];
}

- (void)showLoadingWithText:(NSString *)text toView:(UIView *)view {
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.square = YES;
    self.hud.label.text = text;
}

- (void)hideLoadingView {
    [self.hud hideAnimated:YES];
    self.hud = nil;
}

- (void)hideLoadingViewWithError:(NSString *)error {
    self.hud.label.text = @"失败";
    self.hud.detailsLabel.text = error;
    [self.hud hideAnimated:YES afterDelay:1.0f];
    self.hud = nil;
}

- (void)hideLoadingViewWithSuccess:(NSString *)msg {
    self.hud.label.text = @"成功";
    self.hud.detailsLabel.text = msg;
    [self.hud hideAnimated:YES afterDelay:1.0f];
    self.hud = nil;
}

- (void)showNoResultPrompt {
    self.noResultLabel = [[UILabel alloc] init];
    self.noResultLabel.text = @"没有结果";
    self.noResultLabel.textAlignment = NSTextAlignmentCenter;
    self.noResultLabel.font = [UIFont systemFontOfSize:18];
    self.noResultLabel.textColor = [UIColor grayColor];
    [self.view addSubview:self.noResultLabel];
    
    UIView *superView = self.view;
    [self.noResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
    }];
//    [self.view setNeedsUpdateConstraints];
    
}

- (void)hideNoResultPrompt {
    if (self.noResultLabel) {
        [self.noResultLabel removeFromSuperview];
        self.noResultLabel = nil;
    }
}

#pragma mark - IBAction

- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
