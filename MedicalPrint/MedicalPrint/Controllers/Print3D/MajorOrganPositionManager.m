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
    bones.redPointRect = CGRectMake(82, 14, 3, 3);
    bones.buttonRect = CGRectMake(111 - 70, 14 - 14, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"胸骨";
    bones.enName = @"sternum";
    bones.redPointRect = CGRectMake(73, 82, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手臂";
    bones.enName = @"arm";
    bones.redPointRect = CGRectMake(43, 111, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手骨";
    bones.enName = @"hand bone";
    bones.redPointRect = CGRectMake(10, 216, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"足骨";
    bones.enName = @"foot bone";
    bones.redPointRect = CGRectMake(74, 411, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"肩骨";
    bones.enName = @"shoulder bone";
    bones.redPointRect = CGRectMake(128, 73, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"脊椎";
    bones.enName = @"spine";
    bones.redPointRect = CGRectMake(92, 154, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"盆骨";
    bones.enName = @"pelvis";
    bones.redPointRect = CGRectMake(116, 173, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"腿骨";
    bones.enName = @"leg";
    bones.redPointRect = CGRectMake(105, 352, 3, 3);
    bones.buttonRect = CGRectMake(40, 80, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];

    return bonesArray;
}

+ (void)configureLayoutForBones:(Bones *)bones {
    
}

@end
