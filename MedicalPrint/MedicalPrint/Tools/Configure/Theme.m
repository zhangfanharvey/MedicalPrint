//
//  Theme.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Theme.h"
#import <UIKit/UIKit.h>

@implementation Theme

+ (void)configureNavigationbarStyle
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.031 green:0.765 blue:0.945 alpha:1.00]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],
                                                          NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:18.0f], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.031 green:0.765 blue:0.945 alpha:1.00]];
    
    
}

@end
