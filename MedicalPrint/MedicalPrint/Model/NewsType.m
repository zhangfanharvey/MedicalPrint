//
//  NewsType.m
//  MedicalPrint
//
//  Created by zhang fan on 4/3/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "NewsType.h"

@implementation NewsType

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

- (NSComparisonResult)compare:(id)other
{
    if ([other isKindOfClass:[self class]]) {
        NewsType *otherType = other;
        return [self.orderId compare:otherType.orderId];
    }
    return NSOrderedAscending;
}

@end
