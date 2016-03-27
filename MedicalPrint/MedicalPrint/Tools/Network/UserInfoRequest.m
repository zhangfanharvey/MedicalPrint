//
//  RegisterRequest.m
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "UserInfoRequest.h"
#import "User.h"
#import "AccountManager.h"
#import "AFHTTPSessionManager.h"
#import "AFURLResponseSerialization.h"
#import "ShippingAddress.h"
#import "Order.h"
#import "APIConfigure.h"

@implementation UserInfoRequest

+ (void)registerWithAccount:(NSString *)account password:(NSString *)password phone:(NSString *)phoneNumber code:(NSString *)code withSuccess:(void(^)(User *user, BOOL status))block failure:(void(^)(NSString *error))failure {
    AccountManager *accountManager = [AccountManager sharedManager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:account forKey:@"userName"];
    [dic setObject:password forKey:@"password"];
    [dic setObject:phoneNumber forKey:@"phone"];
    [dic setObject:code forKey:@"code"];
    if (accountManager.token) {
        [dic setObject:accountManager.token forKey:@"token"];
    }

    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPRegisterUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"registerWithAccount success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            User *user = [[User alloc] init];
            [user configureWithDic:bodyDic];
            if (block) {
                block(user, YES);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"registerWithAccount failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)sendCodeWithBlock:(void(^)(NSString *code))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPSendCodeUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"sendCodeWithBlock success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            NSString *codeResult = bodyDic[@"token"];
            [AccountManager sharedManager].token = codeResult;
            if (block) {
                block(codeResult);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"sendCodeWithBlock failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)loginWithAccount:(NSString *)account passwork:(NSString *)password withSuccess:(void(^)(User *user, BOOL loginStatus))block failure:(NetworkFailureBlock)failure {
    AccountManager *accountManager = [AccountManager sharedManager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:account forKey:@"userName"];
    [dic setObject:password forKey:@"password"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPLoginUrl];
    
   [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"loginWithAccount success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
//            NSString *cookie = [NetworkManager sharedManager].responseSerializer;
            QYLog(@"header: %@", ((NSHTTPURLResponse *)task.response).allHeaderFields);
            NSArray *cookies =[[NSArray alloc]init];
            cookies = [NSHTTPCookie
                       cookiesWithResponseHeaderFields:[((NSHTTPURLResponse *)task.response) allHeaderFields]
                       forURL:[NSURL URLWithString:@""]]; // send to URL, return NSArray
            QYLog(@"%@", cookies);
            for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies])
            {
                NSString *cookieName = [cookie name];
                if ([cookieName isEqualToString:@"JSESSIONID"]) {
                    accountManager.cookie = [cookie value];
                }
                QYLog(@"name: '%@'\n",   [cookie name]);
                QYLog(@"value: '%@'\n",  [cookie value]);
                QYLog(@"domain: '%@'\n", [cookie domain]);
                QYLog(@"path: '%@'\n",   [cookie path]);
            }
            User *user = [[User alloc] init];
            [user configureWithDic:bodyDic];
            accountManager.user = user;
            [accountManager saveData];
            if (block) {
                block(user, YES);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"loginWithAccount failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)changePasswordWithNew:(NSString *)password withCode:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    AccountManager *accountManager = [AccountManager sharedManager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:password forKey:@"password"];
    [dic setObject:code forKey:@"code"];
    if (accountManager.token) {
        [dic setObject:accountManager.token forKey:@"token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPRegisterUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"registerWithAccount success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"registerWithAccount failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)changeEmail:(NSString *)email code:(NSString *)code success:(void (^)(BOOL))block failure:(NetworkFailureBlock)failure {
    AccountManager *accountManager = [AccountManager sharedManager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:email forKey:@"email"];
    [dic setObject:code forKey:@"code"];
    if (accountManager.token) {
        [dic setObject:accountManager.token forKey:@"token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPChangeEmailUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"changeEmail success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"changeEmail failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)changePhoneNumber:(NSString *)phone code:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    AccountManager *accountManager = [AccountManager sharedManager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:code forKey:@"code"];
    if (accountManager.token) {
        [dic setObject:accountManager.token forKey:@"token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPChangePhoneUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"changePhoneNumber success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"changePhoneNumber failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)changeUserInfoWithNickname:(NSString *)nickName company:(NSString *)company department:(NSString *)department position:(NSString *)position code:(NSString *)code success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    AccountManager *accountManager = [AccountManager sharedManager];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (nickName) {
        [dic setObject:nickName forKey:@"nickname"];
    }
    if (company) {
        [dic setObject:company forKey:@"company"];
    }
    if (department) {
        [dic setObject:department forKey:@"department"];
    }
    if (position) {
        [dic setObject:position forKey:@"position"];
    }
    [dic setObject:code forKey:@"code"];
    if (accountManager.token) {
        [dic setObject:accountManager.token forKey:@"token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPChangeUserInfoUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"changeUserInfoWithNickname success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"changeUserInfoWithNickname failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchAddressList:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *addressArray))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(start) forKey:@"start"];
    [dic setObject:@(length) forKey:@"length"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchAddressListUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchAddressList success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *orderDic in bodyArray) {
                ShippingAddress *shippingAddress = [[ShippingAddress alloc] init];
                [shippingAddress configureWithDic:orderDic];
                [array addObject:shippingAddress];
            }
            if (block) {
                block(YES, nil);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchAddressList failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)addAddressWithName:(NSString *)name sex:(NSInteger)sex phone:(NSString *)phone address:(NSString *)address success:(void(^)(BOOL status, id responseObject))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:name forKey:@"name"];
    [dic setObject:@(sex) forKey:@"sex"];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:address forKey:@"address"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPAddAddressUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"addAddressWithName success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES, responseObject);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"addAddressWithName failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)updateAddress:(ShippingAddress *)shippingAddress success:(void(^)(BOOL status, ShippingAddress *shippingAddress))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:shippingAddress.p_ID forKey:@"id"];
    [dic setObject:shippingAddress.name forKey:@"name"];
    [dic setObject:@(shippingAddress.sex) forKey:@"sex"];
    [dic setObject:shippingAddress.phone forKey:@"phone"];
    [dic setObject:shippingAddress.address forKey:@"address"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPUpdateAddressUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"updateAddress success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES, responseObject);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"updateAddress failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)deleteAddress:(ShippingAddress *)shippingAddress success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:shippingAddress.p_ID forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPDeleteAddressUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"deleteAddress success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"deleteAddress failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchOrderList:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *orderArray))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(start) forKey:@"start"];
    [dic setObject:@(length) forKey:@"length"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchOrderListUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchOrderList success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (NSDictionary *orderDic in bodyArray) {
                Order *order = [[Order alloc] init];
                [order configureWithDic:orderDic];
                [array addObject:order];
            }
            if (block) {
                block(YES, array);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchOrderList failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)addNewOrder:(Order *)newOrder success:(void(^)(BOOL status, Order *order))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:newOrder.p_ID forKey:@"id"];
    [dic setObject:newOrder.name forKey:@"name"];
    [dic setObject:newOrder.receiver forKey:@"receiver"];
    [dic setObject:@(newOrder.sex) forKey:@"sex"];
    [dic setObject:newOrder.phone forKey:@"phone"];
    [dic setObject:newOrder.address forKey:@"address"];
    [dic setObject:newOrder.source forKey:@"source"];
    [dic setObject:@(newOrder.state) forKey:@"state"];

    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPAddOrderUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"addNewOrder success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES, responseObject);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"addNewOrder failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)updateOrder:(Order *)order success:(void(^)(BOOL status, Order *order))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:order.p_ID forKey:@"id"];
    [dic setObject:order.name forKey:@"name"];
    [dic setObject:order.receiver forKey:@"receiver"];
    [dic setObject:@(order.sex) forKey:@"sex"];
    [dic setObject:order.phone forKey:@"phone"];
    [dic setObject:order.address forKey:@"address"];
    [dic setObject:order.source forKey:@"source"];
    [dic setObject:@(order.state) forKey:@"state"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPUpdateOrderUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"updateOrder success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES, responseObject);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"updateOrder failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}
+ (void)deleteOrder:(Order *)order success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:order.p_ID forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPDeleteOrderUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"deleteOrder success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            if (failure) {
                failure(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"deleteOrder failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

@end
