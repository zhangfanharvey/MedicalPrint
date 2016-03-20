//
//  Order.h
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "id":1，  // 订单标识
 "name":"1"，  // 名称
 " receiver":"张三"，  //收件人姓名
 " sex":"1"，  //收件人性别（1 男 2 女）
 " phone":"13800000000"，  //收件人收件
 "address":"上海市杨浦区"，// 收货地址
 "source":"256115" // 资源下载地址
 "state":"1"，  // 订单状态（0 未完成 1 完成）
 "createTimeStr":"2014-01-01 00:33:00"，  // 订单创建时间
*/

@interface Order : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *receiver;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString *createTimeStr;

- (void)configureWithDic:(NSDictionary *)dic;

@end
