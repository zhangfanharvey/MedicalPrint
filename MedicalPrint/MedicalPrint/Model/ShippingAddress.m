//
//  ShippingAddress.m
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "ShippingAddress.h"

/*
 "id":1，  // 地址标识
 "memberId":1，  // 会员标识
 "name":"1"，  // 收货人姓名
 "sex":1，  // 性别（1 男 2 女）
 "phone":"13811111111"，  // 手机号码
 "address":"13811111111"，  // 详细地址
 */

@implementation ShippingAddress

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    value = dic[@"memberId"];
    if (IsSafeValue(value)) {
        self.memberId = value;
    }

    NSString *valueStr = dic[@"name"];
    if (IsSafeValue(valueStr)) {
        self.name = valueStr;
    }
    value = dic[@"sex"];
    if (IsSafeValue(value)) {
        self.sex = [value integerValue];
    }
    valueStr = dic[@"phone"];
    if (IsSafeValue(valueStr)) {
        self.phone = valueStr;
    }
    valueStr = dic[@"address"];
    if (IsSafeValue(valueStr)) {
        self.address = valueStr;
    }
}

@end
