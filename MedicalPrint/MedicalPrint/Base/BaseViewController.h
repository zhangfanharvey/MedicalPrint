//
//  BaseViewController.h
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

#pragma mark - loading
- (void)showLoadingWithText:(NSString *)text;
- (void)showLoadingWithText:(NSString *)text toView:(UIView *)view;
- (void)hideLoadingView;

@end
