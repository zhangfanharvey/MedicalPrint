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
#import "APIConfigure.h"
#import "AppDelegate.h"

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

- (void)saveUserInfoData {
    [self.user createServerDicFromLocalData];
    [self saveData];
}


- (BOOL)isUserLogin {
    BOOL isLogin = NO;
    if (self.cookie) {
        isLogin = YES;
    }
    return isLogin;
}

- (void)configureCookie {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];

}

- (void)updateCookie {
    if (self.cookie) {
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:@"JSESSIONID" forKey:NSHTTPCookieName];
        [cookieProperties setObject:self.cookie forKey:NSHTTPCookieValue];
        [cookieProperties setObject:kMPBaseHostUrl forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:kMPBaseHostUrl forKey:NSHTTPCookieOriginURL];
        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
        
        // set expiration to one month from now or any NSDate of your choosing
        // this makes the cookie sessionless and it will persist across web sessions and app launches
        /// if you want the cookie to be destroyed when your app exits, don't set this
//        [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
        
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }

}

#pragma mark - search result

- (NSArray *)allSearchResult {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *storedResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"mySearchResult"];
    if (storedResult) {
        [result addObjectsFromArray:storedResult];
    }
    return result;
}

- (void)addSearchResult:(NSString *)text {
    if (text) {
        NSUserDefaults *userDetault = [NSUserDefaults standardUserDefaults];
        NSArray *storedResult = [userDetault objectForKey:@"mySearchResult"];
        NSMutableArray *result = [[NSMutableArray alloc] init];
        if (storedResult) {
            [result addObjectsFromArray:storedResult];
        }
        if (![result containsObject:text]) {
            [result insertObject:text atIndex:0];
        }
        if (result.count > 8) {
            NSInteger limit = 0;
            NSMutableArray *limiteResult = [[NSMutableArray alloc] init];
            for (NSString *tempText in result) {
                if (limit > 8) {
                    break;
                }
                [limiteResult addObject:tempText];
                ++limit;
            }
            [result removeAllObjects];
            [result addObjectsFromArray:limiteResult];
        }
        [userDetault setObject:result forKey:@"mySearchResult"];
        [userDetault synchronize];
    }

}

- (void)logoutAccount {
    self.cookie = nil;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"cookie"];
    [userDefault synchronize];

    AppDelegate *delegagte = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegagte showRegisterView];
    

}


@end
