//
//  MedicalCase.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/31.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalCase.h"

@implementation MedicalCase

/*
 @property (nonatomic, strong) NSString *p_ID;
 @property (nonatomic, strong) NSString *caseTypeId;
 @property (nonatomic, strong) NSString *memberId;
 @property (nonatomic, strong) NSString *nickname;
 @property (nonatomic, strong) NSString *authState;
 @property (nonatomic, strong) NSString *position;
 @property (nonatomic, strong) NSString *title;
 @property (nonatomic, strong) NSString *content;
 @property (nonatomic, strong) NSString *createTimeLong;
*/

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"caseTypeId"];
    if (IsSafeValue(valueStr)) {
        self.caseTypeId = valueStr;
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
    valueStr = dic[@"title"];
    if (IsSafeValue(valueStr)) {
        self.title = valueStr;
    }
    valueStr = dic[@"content"];
    if (IsSafeValue(valueStr)) {
        self.content = valueStr;
    }
    value = dic[@"createTimeLong"];
    if (IsSafeValue(valueStr)) {
        self.createTimeLong = [value doubleValue];
    }

}



@end
