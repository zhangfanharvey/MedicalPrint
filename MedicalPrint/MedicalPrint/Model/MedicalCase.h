//
//  MedicalCase.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/31.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalCase : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *caseTypeId;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *authState;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSTimeInterval createTimeLong;

- (void)configureWithDic:(NSDictionary *)dic;


@end
