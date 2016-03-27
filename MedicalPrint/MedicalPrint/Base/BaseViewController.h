//
//  BaseViewController.h
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


#pragma mark - navigation bar

- (void)initNavBarButtonItemWithImages:(NSArray *)imagesArray action:(SEL)selector isLeft:(BOOL)isLeft;
- (void)initNavBarButtonItemWithTitle:(NSString *)title action:(SEL)selector isLeft:(BOOL)isLeft;

#pragma mark - loading
- (void)showLoadingWithText:(NSString *)text;
- (void)showLoadingWithText:(NSString *)text toView:(UIView *)view;
- (void)hideLoadingView;
- (void)hideLoadingViewWithError:(NSString *)error;

@end
