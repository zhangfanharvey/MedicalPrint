//
//  UIImage+TPAdditions.m
//  YNSocial
//
//  Created by Youni.Zhangfan on 2/10/15.
//  Copyright (c) 2015 Youni.Zhangfan. All rights reserved.
//

#import "UIImage+TPAdditions.h"

@implementation UIImage (TPAdditions)

- (id)initWithContentsOfResolutionIndependentFile:(NSString *)path {
    if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] >= 2.0 ) {
        NSString *path2x = [[path stringByDeletingLastPathComponent]
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@",
                                                            [[path lastPathComponent] stringByDeletingPathExtension],
                                                            [path pathExtension]]];
        
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            return [self initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path2x]] CGImage] scale:2.0 orientation:UIImageOrientationUp];
        }
    }
    
    return [self initWithData:[NSData dataWithContentsOfFile:path]];
}

+ (UIImage*)imageWithContentsOfResolutionIndependentFile:(NSString *)path {
    return [[UIImage alloc] initWithContentsOfResolutionIndependentFile:path];
}

+ (NSString *)imagePathFor2xUrl:(NSString *)path
{
    NSString *imagePathFor2x = path;
    if ( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 && [[UIScreen mainScreen] scale] >= 2.0 ) {
        NSString *path2x = [[path stringByDeletingLastPathComponent]
                            stringByAppendingPathComponent:[NSString stringWithFormat:@"%@@2x.%@",
                                                            [[path lastPathComponent] stringByDeletingPathExtension],
                                                            [path pathExtension]]];
        
        if ( [[NSFileManager defaultManager] fileExistsAtPath:path2x] ) {
            imagePathFor2x = path2x;
        }
    }
    
    return imagePathFor2x;
}

@end
