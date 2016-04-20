//
//  MajorOrganPositionManager.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MajorOrganPositionManager.h"
#import "Bones.h"

@implementation MajorOrganPositionManager

+ (NSMutableArray *)createMajorBones {
    NSMutableArray *bonesArray = [[NSMutableArray alloc] init];
    
    Bones *bones = [[Bones alloc] init];
    bones.cnName = @"颅骨";
    bones.enName = @"skull";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(50, 80);
    bones.lineBreakPoint = CGPointMake(150, 120);
    bones.lineEndPoint = CGPointMake(230, 120);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"胸骨";
    bones.enName = @"sternum";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手臂";
    bones.enName = @"arm";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手骨";
    bones.enName = @"hand bone";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手骨";
    bones.enName = @"";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"足骨";
    bones.enName = @"";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"肩骨";
    bones.enName = @"";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"脊椎";
    bones.enName = @"";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"盆骨";
    bones.enName = @"";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"腿骨";
    bones.enName = @"";
    bones.redPointRect = CGRectMake(0, 0, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(0, 0);
    bones.lineBreakPoint = CGPointMake(0, 0);
    bones.lineEndPoint = CGPointMake(0, 0);
    [bonesArray addObject:bones];

    return bonesArray;
}

+ (void)configureLayoutForBones:(Bones *)bones {
    
}

@end
