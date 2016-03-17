//
//  NetworkManager.h
//  MadicalPrint
//
//  Created by zhang fan on 3/14/16.
//  Copyright © 2016 zhangfan. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface NetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
