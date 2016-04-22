//
//  CaseType.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "CaseType.h"

@implementation CaseType

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

- (NSString *)iconImageName {
    NSString *imageName = nil;
    switch ([self.p_ID longLongValue]) {
        case 1:
        {
            imageName = @"头骨";
        }
            break;
        case 2:
        {
            imageName = @"胸骨_常态";
        }
            break;
        case 3:
        {
            imageName = @"手臂_常态";
        }
            break;
        case 4:
        {
            imageName = @"手骨_常态";
        }
            break;
        case 5:
        {
            imageName = @"肩骨_常态";
        }
            break;
        case 6:
        {
            imageName = @"脊柱_常态";
        }
            break;
        case 7:
        {
            imageName = @"盆骨_常态";
        }
            break;
        case 8:
        {
            imageName = @"腿骨_常态";
        }
            break;

        case 9:
        {
            imageName = @"足骨_按下";
        }
            break;
            
        default:
            break;
    }
    return imageName;
}

@end
