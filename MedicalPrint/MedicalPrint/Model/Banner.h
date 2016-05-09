//
//  Banner.h
//  MedicalPrint
//
//  Created by zhangfan on 16/5/9.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl;

- (void)configureWithDic:(NSDictionary *)dic;

@end
