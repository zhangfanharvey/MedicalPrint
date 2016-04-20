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

- (NSString *)iconImageName {
    NSString *imageName = nil;
    switch ([self.p_ID longLongValue]) {
        case 0:
        {
            imageName = @"转化_按下";
        }
            break;
        case 1:
        {
            imageName = @"科研_常态";
        }
            break;
        case 2:
        {
            imageName = @"教育_常态";
        }
            break;
        case 3:
        {
            imageName = @"服务_常态";
        }
            break;
        case 4:
        {
            imageName = @"转化_常态";
        }
            break;
        case 5:
        {
            imageName = @"转化_常态"; //教育
        }
            break;
        case 6:
        {
            imageName = @"转化_常态"; //科研
        }
            break;

        default:
            break;
    }
    return imageName;
}

@end
