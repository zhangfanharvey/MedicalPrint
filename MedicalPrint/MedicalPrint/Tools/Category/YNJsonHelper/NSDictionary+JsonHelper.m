//
//  NSDictionary+JsonHelper.m
//  IBeaconChat
//
//  Created by Youni.Zhangfan on 7/4/14.
//  Copyright (c) 2014 Youni.Zhangfan. All rights reserved.
//

#import "NSDictionary+JsonHelper.h"
#import "Common.h"

@implementation NSDictionary (JsonHelper)

- (NSString *)jsonString
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (!jsonData) {
        QYLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSString *)unReadJsonString
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (!jsonData) {
        QYLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

@end
