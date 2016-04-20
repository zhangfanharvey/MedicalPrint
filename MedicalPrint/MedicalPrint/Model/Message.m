//
//  Message.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Message.h"

@implementation Message

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"contents"];
    if (IsSafeValue(valueStr)) {
        self.contents = valueStr;
    }
    value = dic[@"createTimeLong"];
    if (IsSafeValue(valueStr)) {
        self.createTimeLong = [valueStr longLongValue];
    }
}

- (NSString *)crateTimeStr {
    NSString *time = nil;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    time = [formater stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.createTimeLong]];
    return time;
}

@end
