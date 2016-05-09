//
//  Banner.m
//  MedicalPrint
//
//  Created by zhangfan on 16/5/9.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Banner.h"

@implementation Banner

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"title"];
    if (IsSafeValue(valueStr)) {
        self.title = valueStr;
    }
    valueStr = dic[@"imgUrl"];
    if (IsSafeValue(valueStr)) {
        self.imgUrl = valueStr;
    }
}

@end
