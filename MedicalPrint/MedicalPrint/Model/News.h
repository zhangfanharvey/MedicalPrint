//
//  News.h
//  MedicalPrint
//
//  Created by zhang fan on 4/3/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *newsTypeId;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *authState;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *createTimeLong;
@property (nonatomic, strong) NSString *createTimeStr;
@property (nonatomic, strong) NSString *newsTypeName;
@property (nonatomic, strong) NSString *newsDescription;

- (void)configureWithDic:(NSDictionary *)dic;

- (NSString *)iconImageUrl;

- (NSString *)newsDetailUrl;

@end
