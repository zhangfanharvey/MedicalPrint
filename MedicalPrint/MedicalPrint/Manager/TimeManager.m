//
//  TimeManager.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "TimeManager.h"

@implementation TimeManager

+ (NSString *)timeStringFromInterval:(NSTimeInterval)timeInterval {
    NSString *time = nil;
    static NSDateFormatter *formater;
    formater = [[NSDateFormatter alloc] init];
    time = [formater stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return time;

}

@end
