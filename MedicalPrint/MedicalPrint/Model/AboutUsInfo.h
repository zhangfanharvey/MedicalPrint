//
//  AbountUsInfo.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/29.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AboutUsInfo : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *introduction;

- (void)configureWithDic:(NSDictionary *)dic;

@end
