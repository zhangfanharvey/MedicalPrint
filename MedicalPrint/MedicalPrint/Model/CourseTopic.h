//
//  CourseTopic.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/13.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseTopic : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *content;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSString *)iconImageUrl;

@end
