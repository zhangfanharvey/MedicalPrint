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
#import "CaseType.h"
#import "AboutUsInfo.h"
#import "MedicalCase.h"
#import "MedicalCaseReply.h"
#import "NewsType.h"
#import "News.h"

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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
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
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"deleteOrder failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}
+ (void)fetchListCaseTypeWithSuccess:(void(^)(BOOL status, NSArray *caseTypeArray))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchListCaseTypeUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchListCaseTypeWithSuccess success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *caseTypeArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in bodyArray) {
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    CaseType *caseType = [[CaseType alloc] init];
                    [caseType configureWithDic:dic];
                    [caseTypeArray addObject:caseType];
                }
            }
            if (block) {
                block(YES, caseTypeArray);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchListCaseTypeWithSuccess failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchMedicalCaseListForType:(CaseType *)caseType withStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *medicalCaseArray))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchMedicalCaseUrl];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:caseType.p_ID forKey:@"id"];
    [dic setObject:@(start) forKey:@"start"];
    [dic setObject:@(length) forKey:@"length"];

    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchMedicalCaseListForType success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *meicalcaseArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in bodyArray) {
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    MedicalCase *medicalCase = [[MedicalCase alloc] init];
                    [medicalCase configureWithDic:dic];
                    [meicalcaseArray addObject:medicalCase];
                }
            }
            if (block) {
                block(YES, meicalcaseArray);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchMedicalCaseListForType failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchMyMedicalCaseListStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *medicalCaseArray))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchMyMedicalCaseUrl];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(start) forKey:@"start"];
    [dic setObject:@(length) forKey:@"length"];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchMyMedicalCaseListStart success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *meicalcaseArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in bodyArray) {
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    MedicalCase *medicalCase = [[MedicalCase alloc] init];
                    [medicalCase configureWithDic:dic];
                    [meicalcaseArray addObject:medicalCase];
                }
            }
            if (block) {
                block(YES, meicalcaseArray);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchMyMedicalCaseListStart failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)addMyMedicalCaseForType:(CaseType *)caseType withTitle:(NSString *)title content:(NSString *)content success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:caseType.p_ID forKey:@"caseTypeId"];
    [dic setObject:title forKey:@"title"];
    [dic setObject:content forKey:@"content"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPAddMyMedicalCaseUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"addMyMedicalCaseForType success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
//            NSDictionary *responseDic = (NSDictionary *)responseObject;
//            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"addMyMedicalCaseForType failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)updateMyMedicalCaseFor:(MedicalCase *)medicalCase success:(void(^)(BOOL status, MedicalCase *medicalCase))block failure:(NetworkFailureBlock)failure {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:medicalCase.p_ID forKey:@"caseTypeId"];
    [dic setObject:medicalCase.title forKey:@"title"];
    [dic setObject:medicalCase.content forKey:@"content"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPUpdateMyMedicalCaseUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"updateMyMedicalCaseFor success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
//            NSDictionary *responseDic = (NSDictionary *)responseObject;
//            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES, medicalCase);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"updateMyMedicalCaseFor failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];

}

+ (void)fetchAboutUsWithSuccess:(void(^)(BOOL status, AboutUsInfo *aboutUsInfo))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchAboutUsInfoUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchAboutUsWithSuccess success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSDictionary *bodyDic = responseDic[@"body"];
            AboutUsInfo *abountUsInfo = [[AboutUsInfo alloc] init];
            if (bodyDic && [bodyDic isKindOfClass:[NSDictionary class]]) {
                [abountUsInfo configureWithDic:bodyDic];
            }
            if (block) {
                block(YES, abountUsInfo);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchAboutUsWithSuccess failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)sendFeedbackWithConten:(NSString *)content success:(void(^)(BOOL status))block failure:(NetworkFailureBlock)failure {
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPSendFeedbackUrl];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:content forKey:@"content"];

    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"sendFeedbackWithConten success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
//            NSDictionary *responseDic = (NSDictionary *)responseObject;
//            NSDictionary *bodyDic = responseDic[@"body"];
            if (block) {
                block(YES);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"sendFeedbackWithConten failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchNewsTypeSuccess:(void(^)(BOOL status, NSArray *newsTypeArray))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchListNewsTypeUrl];
    
    [[NetworkManager sharedManager] POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchNewsTypeSuccess success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *caseTypeArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in bodyArray) {
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    NewsType *newsType = [[NewsType alloc] init];
                    [newsType configureWithDic:dic];
                    [caseTypeArray addObject:newsType];
                }
            }
            if (block) {
                block(YES, caseTypeArray);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchNewsTypeSuccess failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchMyNewsListStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *newsArray))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchMyNewsUrl];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(start) forKey:@"start"];
    [dic setObject:@(length) forKey:@"length"];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchMyNewsListStart success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *meicalcaseArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in bodyArray) {
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    News *news = [[News alloc] init];
                    [news configureWithDic:dic];
                    [meicalcaseArray addObject:news];
                }
            }
            if (block) {
                block(YES, meicalcaseArray);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchMyNewsListStart failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

+ (void)fetchNewsListForType:(NewsType *)newsType withStart:(NSInteger)start length:(NSInteger)length success:(void(^)(BOOL status, NSArray *newsArray))block failure:(NetworkFailureBlock)failure {
    NSString *url = [NSString stringWithFormat:@"%@%@", kMPBaseUrl, kMPFetchMedicalCaseUrl];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:newsType.p_ID forKey:@"id"];
    [dic setObject:@(start) forKey:@"start"];
    [dic setObject:@(length) forKey:@"length"];
    
    [[NetworkManager sharedManager] POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"fetchNewsListForType success%@", responseObject);
        if ([NetworkManager isResponseSuccess:responseObject]) {
            NSDictionary *responseDic = (NSDictionary *)responseObject;
            NSArray *bodyArray = responseDic[@"body"];
            NSMutableArray *meicalcaseArray = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in bodyArray) {
                if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                    News *news = [[News alloc] init];
                    [news configureWithDic:dic];
                    [meicalcaseArray addObject:news];
                }
            }
            if (block) {
                block(YES, meicalcaseArray);
            }
        } else {
            NSString *errorMsg = responseObject[@"msg"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        QYLog(@"fetchNewsListForType failure :%@", error.localizedDescription);
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

@end
