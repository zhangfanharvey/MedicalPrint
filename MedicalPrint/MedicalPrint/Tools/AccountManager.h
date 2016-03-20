//
//  AccountManager.h
//  MedicalPrint
//
//  Created by zhang fan on 3/20/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *cookie;

- (void)saveData;
- (void)readData;

@end
