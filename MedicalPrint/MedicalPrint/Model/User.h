//
//  User.h
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "id":1，  // 用户标识
 "nickname":1，  // 姓名
 "userName":1，  // 登陆名
 "phone":"13811111111"，  // 手机
 "email ":"13811111111"，  // 邮箱
 "company ":"13811111111"，  // 单位
 "department ":"13811111111"，  // 科室
 "position ":"13811111111"，  // 职位
 "authState":"13811111111"，  // 认证状态（0 未认证 1 审核中 2 已认证）
*/

@interface User : NSObject

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *authState;
@property (nonatomic, assign) NSInteger closeApns; // 推送消息状态（1 开启 2 关闭）

@property (nonatomic, strong) NSDictionary *serverDic;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSMutableDictionary *)createServerDicFromLocalData;

- (NSString *)showNickName;

@end
