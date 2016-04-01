//
//  AbountUsInfo.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/29.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "AboutUsInfo.h"

@implementation AboutUsInfo

/*
 @property (nonatomic, strong) NSString *p_ID;
 @property (nonatomic, strong) NSString *phoneNumber;
 @property (nonatomic, strong) NSString *fax;
 @property (nonatomic, strong) NSString *email;
 @property (nonatomic, strong) NSString *address;
 @property (nonatomic, strong) NSString *introduction;
*/
- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"phoneNumber"];
    if (IsSafeValue(valueStr)) {
        self.phoneNumber = valueStr;
    }
    valueStr = dic[@"fax"];
    if (IsSafeValue(valueStr)) {
        self.fax = valueStr;
    }
    valueStr = dic[@"email"];
    if (IsSafeValue(valueStr)) {
        self.email = valueStr;
    }
    valueStr = dic[@"address"];
    if (IsSafeValue(valueStr)) {
        self.address = valueStr;
    }
    valueStr = dic[@"introduction"];
    if (IsSafeValue(valueStr)) {
        self.introduction = valueStr;
    }
}

@end
