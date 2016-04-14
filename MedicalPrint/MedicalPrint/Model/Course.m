//
//  Course.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/13.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Course.h"
#import "APIConfigure.h"

@implementation Course

- (void)configureWithDic:(NSDictionary *)dic {
    NSNumber *value = dic[@"id"];
    if (IsSafeValue(value)) {
        self.p_ID = [value stringValue];
    }
    NSString *valueStr = dic[@"title"];
    if (IsSafeValue(valueStr)) {
        self.title = valueStr;
    }
    valueStr = dic[@"icon"];
    if (IsSafeValue(valueStr)) {
        self.icon = valueStr;
    }
    valueStr = dic[@"content"];
    if (IsSafeValue(valueStr)) {
        self.content = valueStr;
    }
    valueStr = dic[@"startTime"];
    if (IsSafeValue(valueStr)) {
        self.endTime = valueStr;
    }
    valueStr = dic[@"endTime"];
    if (IsSafeValue(valueStr)) {
        self.endTime = valueStr;
    }

}

- (NSString *)iconImageUrl {
    NSString *url = nil;
    if (self.icon) {
        url = [NSString stringWithFormat:@"%@/%@", kMPBaseUrl, self.icon];
    }
    return url;
}

@end
