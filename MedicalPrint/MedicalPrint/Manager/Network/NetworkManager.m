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

//        [cookieProperties setObject:@"username" forKey:NSHTTPCookieName];
//        [cookieProperties setObject:@"rainbird" forKey:NSHTTPCookieValue];
//        [cookieProperties setObject:@"cnrainbird.com" forKey:NSHTTPCookieDomain];
//        [cookieProperties setObject:@"cnrainbird.com" forKey:NSHTTPCookieOriginURL];
//        [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//        [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
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
            status = [state integerValue] == 1;
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

@end
