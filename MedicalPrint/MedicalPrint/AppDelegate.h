//
//  AppDelegate.h
//  MedicalPrint
//
//  Created by zhang fan on 3/15/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MainTabController *mainTabVC;

- (void)showHomeView;


@end

