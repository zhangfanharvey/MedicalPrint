//
//  NetworkManager.m
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import "NetworkManager.h"
#import "AccountManager.h"

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [NetworkManager manager];
        instance.responseSerializer.acceptableContentTypes = [instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        instance.requestSerializer.HTTPShouldHandleCookies = YES;

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

@end
