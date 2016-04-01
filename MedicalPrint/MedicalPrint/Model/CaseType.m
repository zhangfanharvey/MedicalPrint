//
//  CaseType.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "CaseType.h"

@implementation CaseType

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"name"];
    if (IsSafeValue(valueStr)) {
        self.name = valueStr;
    }
    valueStr = dic[@"icon"];
    if (IsSafeValue(valueStr)) {
        self.icon = valueStr;
    }
    valueStr = dic[@"orderId"];
    if (IsSafeValue(valueStr)) {
        self.orderId = [NSNumber numberWithLongLong:[valueStr longLongValue]];
    }
}

@end
