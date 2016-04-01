//
//  MedicalCaseReply.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/31.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalCaseReply.h"

@implementation MedicalCaseReply

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"caseId"];
    if (IsSafeValue(valueStr)) {
        self.caseId = valueStr;
    }
    valueStr = dic[@"memberId"];
    if (IsSafeValue(valueStr)) {
        self.memberId = valueStr;
    }
    valueStr = dic[@"nickname"];
    if (IsSafeValue(valueStr)) {
        self.nickname = valueStr;
    }
    valueStr = dic[@"authState"];
    if (IsSafeValue(valueStr)) {
        self.authState = valueStr;
    }
    valueStr = dic[@"position"];
    if (IsSafeValue(valueStr)) {
        self.position = valueStr;
    }
    valueStr = dic[@"content"];
    if (IsSafeValue(valueStr)) {
        self.content = valueStr;
    }
    valueStr = dic[@"createTimeLong"];
    if (IsSafeValue(valueStr)) {
        self.createTimeLong = valueStr;
    }
    
}

@end
