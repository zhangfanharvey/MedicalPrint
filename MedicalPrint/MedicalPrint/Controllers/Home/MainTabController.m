//
//  MainTabController.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "MainTabController.h"
#import "HomeViewController.h"
#import "MedicalHelpController.h"
#import "Print3DController.h"
#import "SettingsViewController.h"
#import "UserPersonalCenterController.h"
#import "YouniNavigationController.h"
#import "UserInfoRequest.h"


@interface MainTabController () <UITabBarControllerDelegate>

@property (nonatomic, strong) YouniNavigationController *homeNav;
@property (nonatomic, strong) YouniNavigationController *printNav;
@property (nonatomic, strong) YouniNavigationController *medicallNav;
@property (nonatomic, strong) YouniNavigationController *myNav;
@property (nonatomic, strong) YouniNavigationController *moreNav;

@end

@implementation MainTabController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        self.homeNav = [[YouniNavigationController alloc] initWithRootViewController:homeVC];
        [array addObject:self.homeNav];
        
        Print3DController *print3DVC = [[Print3DController alloc] init];
        self.printNav = [[YouniNavigationController alloc] initWithRootViewController:print3DVC];
        [array addObject:self.printNav];

        MedicalHelpController *medicaHelplVC = [[MedicalHelpController alloc] init];
        self.medicallNav = [[YouniNavigationController alloc] initWithRootViewController:medicaHelplVC];
        [array addObject:self.medicallNav];

        UserPersonalCenterController *settingsVC = [[UserPersonalCenterController alloc] init];
        self.myNav = [[YouniNavigationController alloc] initWithRootViewController:settingsVC];
        [array addObject:self.myNav];

        SettingsViewController *home = [[SettingsViewController alloc] init];
        self.moreNav = [[YouniNavigationController alloc] initWithRootViewController:home];
        [array addObject:self.moreNav];

        self.viewControllers = array;
        self.delegate = self;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate





@end
