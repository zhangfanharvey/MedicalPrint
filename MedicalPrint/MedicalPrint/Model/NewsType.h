//
//  NewsType.h
//  MedicalPrint
//
//  Created by zhang fan on 4/3/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsType : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *orderId;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSString *)iconImageName;

@end
