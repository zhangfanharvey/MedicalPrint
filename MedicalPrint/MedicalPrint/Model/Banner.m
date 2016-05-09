//
//  Banner.m
//  MedicalPrint
//
//  Created by zhangfan on 16/5/9.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Banner.h"
#import "APIConfigure.h"

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

- (NSString *)bannerDetailUrl {
    NSString *url = nil;
    if (self.p_ID) {
        url = [NSString stringWithFormat:@"%@/app/homepage/bannerDetail.do?id=%@", kMPBaseUrl, self.p_ID];
    }
    return url;
}

@end
