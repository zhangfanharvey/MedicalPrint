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

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation BaseViewController

#pragma mark - loading
- (void)showLoadingWithText:(NSString *)text {
    [self showLoadingWithText:text toView:self.view];
}

- (void)showLoadingWithText:(NSString *)text toView:(UIView *)view {
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.label.text = text;
}

- (void)hideLoadingView {
    [self.hud hideAnimated:YES];
    self.hud = nil;
}



@end
