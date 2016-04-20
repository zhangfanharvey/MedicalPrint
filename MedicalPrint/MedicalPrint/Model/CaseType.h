//
//  CaseType.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseType : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *orderId;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSString *)iconImageName;

@end
