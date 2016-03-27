//
//  NSArray+JsonHelper.m
//  YNSocial
//
//  Created by Youni.Zhangfan on 12/8/14.
//  Copyright (c) 2014 Youni.Zhangfan. All rights reserved.
//

#import "NSArray+JsonHelper.h"
#import "Common.h"

@implementation NSArray (JsonHelper)

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

@end
