//
//  ShippingAddress.h
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "id":1，  // 地址标识
 "memberId":1，  // 会员标识
 "name":"1"，  // 收货人姓名
 "sex":1，  // 性别（1 男 2 女）
 "phone":"13811111111"，  // 手机号码
 "address":"13811111111"，  // 详细地址
*/

@interface ShippingAddress : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSNumber *memberId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;

- (void)configureWithDic:(NSDictionary *)dic;


@end
