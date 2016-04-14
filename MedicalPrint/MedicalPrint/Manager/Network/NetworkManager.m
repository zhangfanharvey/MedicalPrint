//
//  NetworkManager.m
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "AccountManager.h"
#import "AppDelegate.h"
#import "MainTabController.h"

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NetworkManager manager];
        instance.responseSerializer.acceptableContentTypes = [instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//        instance.requestSerializer.HTTPShouldHandleCookies = YES;
        
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//        NSArray *cookieStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
//        NSDictionary *cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieStorage];
        if ([AccountManager sharedManager].cookie) {
            [cookieProperties setObject:[AccountManager sharedManager].cookie forKey:@"JSESSIONID"];
            [instance.requestSerializer setValue:[AccountManager sharedManager].cookie forHTTPHeaderField:@"JSESSIONID"];
            [cookieProperties setObject:[NSString stringWithFormat:@"%@=%@", @"JSESSIONID", [AccountManager sharedManager].cookie] forKey:@"Cookie"];
            [instance.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", @"JSESSIONID", [AccountManager sharedManager].cookie] forHTTPHeaderField:@"Cookie"];
        }
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            NSLog(@"before %@", cookie);
        }
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
            NSLog(@"after %@", cookie);
        }

    });
    return instance;
}

+ (BOOL)isResponseSuccess:(NSString *)responseObject {
    BOOL status = NO;
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSNumber *state = dic[@"state"];
        if (state && [state isKindOfClass:[NSNumber class]]) {
            if ([state integerValue] == 3) {
                AppDelegate *delegagte = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [delegagte showRegisterView];
            } else if ([state integerValue] == 1) {
                status = YES;
            }
        }
    }
    return status;
}

- (void)setCookieForHeader {
    AccountManager *accountManager = [AccountManager sharedManager];
    if (accountManager.cookie) {
        [self.requestSerializer setValue:accountManager.cookie forHTTPHeaderField:@"Cookie"];
    }
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    if ([AccountManager sharedManager].cookie) {
        [self.requestSerializer setValue:[AccountManager sharedManager].cookie forHTTPHeaderField:@"JSESSIONID"];
        [self.requestSerializer setValue:[AccountManager sharedManager].cookie forHTTPHeaderField:@"Cookie"];
        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@=%@", @"JSESSIONID", [AccountManager sharedManager].cookie] forHTTPHeaderField:@"Cookie"];


    }
    return [super POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}

- (void)showLoginStatusExpire {
    AppDelegate *delegagte = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegagte showRegisterView];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录已过期" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ;
    }];
    [alertController addAction:action];
    [delegagte.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
