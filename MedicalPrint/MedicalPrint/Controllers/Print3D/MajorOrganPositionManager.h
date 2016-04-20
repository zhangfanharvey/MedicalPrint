//
//  MajorOrganPositionManager.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bones;

@interface MajorOrganPositionManager : NSObject

+ (NSMutableArray *)createMajorBones;

+ (void)configureLayoutForBones:(Bones *)bones;

@end
