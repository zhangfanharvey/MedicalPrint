//
//  Message.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, assign) NSTimeInterval createTimeLong;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSString *)crateTimeStr;

@end
