//
//  NSString+JsonHelper.m
//  IBeaconChat
//
//  Created by Youni.Zhangfan on 7/5/14.
//  Copyright (c) 2014 Youni.Zhangfan. All rights reserved.
//

#import "NSString+JsonHelper.h"

@implementation NSString (JsonHelper)

- (id)jsonValue
{
    NSError* error;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        NSString *str = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        return json;
    }
    return json;
}

- (id)mutableJsonValue
{
    NSError* error;
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSString *str = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers error:&error];
        return json;
    }
    return json;
}

@end
