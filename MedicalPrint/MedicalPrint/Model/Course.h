//
//  Course.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/13.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSString *)iconImageUrl;

@end
