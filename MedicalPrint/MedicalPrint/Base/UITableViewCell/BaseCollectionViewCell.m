//
//  BaseCollectionViewCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

+ (NSString *)cellIdentifier {
    static NSString *cellIdentifier = nil;
    cellIdentifier = [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(self)];
    return cellIdentifier;
}

@end
