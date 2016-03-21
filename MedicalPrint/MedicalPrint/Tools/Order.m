//
//  Order.m
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "Order.h"

/*
 "id":1，  // 订单标识
 "name":"1"，  // 名称
 " receiver":"张三"，  //收件人姓名
 " sex":"1"，  //收件人性别（1 男 2 女）
 " phone":"13800000000"，  //收件人收件
 "address":"上海市杨浦区"，// 收货地址
 "source":"256115" // 资源下载地址
 "state":"1"，  // 订单状态（0 未完成 1 完成）
 "createTimeStr":"2014-01-01 00:33:00"，  // 订单创建时间
 */

@implementation Order

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
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
    valueStr = dic[@"source"];
    if (IsSafeValue(valueStr)) {
        self.source = valueStr;
    }
    value = dic[@"state"];
    if (IsSafeValue(value)) {
        self.state = [value integerValue];
    }

    valueStr = dic[@"createTimeStr"];
    if (IsSafeValue(valueStr)) {
        self.createTimeStr = valueStr;
    }


}
@end
