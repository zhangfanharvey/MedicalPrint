//
//  AccountManager.m
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "AccountManager.h"
#import "User.h"
#import "NSDictionary+JsonHelper.h"
#import "NSString+JsonHelper.h"

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
    if (self.user.serverDic) {
        [userDefault setObject:[self.user.serverDic jsonString] forKey:@"user.serverDic"];
    }
}

- (void)readData {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.cookie = [userDefault objectForKey:@"cookie"];
    self.token = [userDefault objectForKey:@"token"];
    
    NSString *serverStr = [userDefault objectForKey:@"token"];
    if (serverStr) {
        NSDictionary *serverDic = [serverStr jsonValue];
        if (serverDic) {
            if (!self.user) {
                self.user = [[User alloc] init];
            }
            [self.user configureWithDic:serverDic];
        }
    }
}


- (BOOL)isUserLogin {
    BOOL isLogin = NO;
    if (self.cookie) {
        isLogin = YES;
    }
    return isLogin;
}

@end
