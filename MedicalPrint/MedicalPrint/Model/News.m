//
//  News.m
//  MedicalPrint
//
//  Created by zhang fan on 4/3/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "News.h"

@implementation News

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"newsTypeId"];
    if (IsSafeValue(valueStr)) {
        self.newsTypeId = valueStr;
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
    valueStr = dic[@"icon"];
    if (IsSafeValue(valueStr)) {
        self.icon = valueStr;
    }
    valueStr = dic[@"createTimeLong"];
    if (IsSafeValue(valueStr)) {
        self.createTimeLong = valueStr;
    }
    valueStr = dic[@"createTimeStr"];
    if (IsSafeValue(valueStr)) {
        self.createTimeStr = valueStr;
    }
    valueStr = dic[@"newsTypeName"];
    if (IsSafeValue(valueStr)) {
        self.newsTypeName = valueStr;
    }

}

@end
