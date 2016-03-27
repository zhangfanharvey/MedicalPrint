//
//  User.m
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "User.h"

/**
 "id":1，  // 用户标识
 "nickname":1，  // 姓名
 "userName":1，  // 登陆名
 "phone":"13811111111"，  // 手机
 "email ":"13811111111"，  // 邮箱
 "company ":"13811111111"，  // 单位
 "department ":"13811111111"，  // 科室
 "position ":"13811111111"，  // 职位
 "authState":"13811111111"，  // 认证状态（0 未认证 1 审核中 2 已认证）
 */

@implementation User

- (void)configureWithDic:(NSDictionary *)dic {
    if (dic) {
        self.serverDic = dic;
    }
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.uid = [value stringValue];
    }
    NSString *valueStr = dic[@"nickname"];
    if (IsSafeValue(valueStr)) {
        self.nickName = valueStr;
    }
    valueStr = dic[@"userName"];
    if (IsSafeValue(valueStr)) {
        self.account = valueStr;
    }
    valueStr = dic[@"phone"];
    if (IsSafeValue(valueStr)) {
        self.phone = valueStr;
    }
    valueStr = dic[@"email"];
    if (IsSafeValue(valueStr)) {
        self.email = valueStr;
    }
    valueStr = dic[@"company"];
    if (IsSafeValue(valueStr)) {
        self.company = valueStr;
    }
    valueStr = dic[@"department"];
    if (IsSafeValue(valueStr)) {
        self.department = valueStr;
    }
    valueStr = dic[@"position"];
    if (IsSafeValue(valueStr)) {
        self.position = valueStr;
    }
    valueStr = dic[@"authState"];
    if (IsSafeValue(valueStr)) {
        self.authState = valueStr;
    }
}

@end
