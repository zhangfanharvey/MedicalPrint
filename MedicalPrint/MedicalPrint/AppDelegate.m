//
//  AppDelegate.m
//  MedicalPrint
//
//  Created by zhang fan on 3/15/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "AppDelegate.h"
#import "AccountManager.h"
#import "RegisterAndLoginController.h"
#import "YouniNavigationController.h"
#import "Theme.h"
#import "MainTabController.h"

@interface AppDelegate ()



@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self globalSetting];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    AccountManager *accountManager = [AccountManager sharedManager];
    [accountManager readData];
    if ([accountManager isUserLogin] ) {
        [self showHomeView];
    } else {
        [self showRegisterView];
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private

- (void)showRegisterView {
    RegisterAndLoginController *registerLoginVC = [[RegisterAndLoginController alloc] init];
    YouniNavigationController *nav =[[YouniNavigationController alloc] initWithRootViewController:registerLoginVC];
    self.window.rootViewController = nav;
}

- (void)showHomeView {
    MainTabController *mainVC = [[MainTabController alloc] init];
    self.mainTabVC = mainVC;
    self.window.rootViewController = mainVC;
}

- (void)globalSetting {
    [Theme configureNavigationbarStyle];
}

@end
