//
//  UIImage+TPAdditions.h
//  YNSocial
//
//  Created by Youni.Zhangfan on 2/10/15.
//  Copyright (c) 2015 Youni.Zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TPAdditions)
- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path;
+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path;

+ (NSString *)imagePathFor2xUrl:(NSString *)path;

@end
