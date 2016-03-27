//
//  AccountManager.h
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface AccountManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *cookie;

@property (nonatomic, strong) User *user;

- (void)saveData;
- (void)readData;

- (BOOL)isUserLogin;

@end
