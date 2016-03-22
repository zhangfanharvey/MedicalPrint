//
//  AccountManager.m
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager

+ (instancetype)sharedManager {
    static AccountManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AccountManager alloc] init];
    });
    return instance;
}

- (void)saveData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (self.cookie) {
        [userDefault setObject:self.cookie forKey:@"cookie"];
    }
    if (self.token) {
        [userDefault setObject:self.cookie forKey:@"token"];
    }
}

- (void)readData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.cookie = [userDefault objectForKey:@"cookie"];
}


- (BOOL)isUserLogin {
    BOOL isLogin = NO;
    return isLogin;
}

@end
