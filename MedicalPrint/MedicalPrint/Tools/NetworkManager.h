//
//  NetworkManager.h
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"


typedef void(^NetworkFailureBlock)(NSString *msg);

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

+ (BOOL)isResponseSuccess:(id)responseObject;

@end
