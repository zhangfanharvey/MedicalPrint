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
    bones.buttonRect = CGRectMake(111 - 70, 14, 70, 26);
    bones.lineStartPoint = CGPointMake(110, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"胸骨";
    bones.enName = @"sternum";
    bones.redPointRect = CGRectMake(73, 82, 3, 3);
    bones.buttonRect = CGRectMake(96 - 70, CGRectGetMinY(bones.redPointRect) - 29, 70, 26);
    bones.lineStartPoint = CGPointMake(95, CGRectGetMinY(bones.redPointRect) - 29);
    bones.lineBreakPoint = CGPointMake(95 + 45, CGRectGetMinY(bones.redPointRect) - 29);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手臂";
    bones.enName = @"arm";
    bones.redPointRect = CGRectMake(43, 111, 3, 3);
    bones.buttonRect = CGRectMake(90 - 70, 111, 70, 26);
    bones.lineStartPoint = CGPointMake(90, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineBreakPoint = CGPointMake(90 + 10, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"手骨";
    bones.enName = @"hand bone";
    bones.redPointRect = CGRectMake(10, 216, 3, 3);
    bones.buttonRect = CGRectMake(60 - 35, CGRectGetMinY(bones.redPointRect) + 24, 70, 26);
    bones.lineStartPoint = CGPointMake(60, CGRectGetMinY(bones.redPointRect) + 25);
    bones.lineBreakPoint = CGPointMake(60, CGRectGetMinY(bones.redPointRect) + 1);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    bones.alignment = BonesAlignmentBottom;
    [bonesArray addObject:bones];

    bones = [[Bones alloc] init];
    bones.cnName = @"足骨";
    bones.enName = @"foot bone";
    bones.redPointRect = CGRectMake(74, 411, 3, 3);
    bones.buttonRect = CGRectMake(90 - 70, CGRectGetMinY(bones.redPointRect) - 23, 70, 26);
    bones.lineStartPoint = CGPointMake(90, CGRectGetMinY(bones.redPointRect) - 23);
    bones.lineBreakPoint = CGPointMake(122, CGRectGetMinY(bones.redPointRect) - 23);
    bones.lineEndPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) + 1);
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"肩骨";
    bones.enName = @"shoulder bone";
    bones.redPointRect = CGRectMake(128, 73, 3, 3);
    bones.buttonRect = CGRectMake(14 + 15, - 17, 70, 26);
    bones.lineStartPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect));
    bones.lineBreakPoint = CGPointMake(14,  - 17);
    bones.lineEndPoint = CGPointMake(14 + 15,  - 17);
    bones.alignment = BonesAlignmentRight;
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"脊椎";
    bones.enName = @"spine";
    bones.redPointRect = CGRectMake(92, 154, 3, 3);
    bones.buttonRect = CGRectMake(61 + 20,  - 59, 70, 26);
    bones.lineStartPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) );
    bones.lineBreakPoint = CGPointMake( 61,  - 59);
    bones.lineEndPoint = CGPointMake( 61 + 20,  - 59);
    bones.alignment = BonesAlignmentRight;
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"盆骨";
    bones.enName = @"pelvis";
    bones.redPointRect = CGRectMake(116, 173, 3, 3);
    bones.buttonRect = CGRectMake(38 + 20,  - 27, 70, 26);
    bones.lineStartPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect) );
    bones.lineBreakPoint = CGPointMake(38,  - 27);
    bones.lineEndPoint = CGPointMake(38 + 20, - 27);
    bones.alignment = BonesAlignmentRight;
    [bonesArray addObject:bones];
    
    bones = [[Bones alloc] init];
    bones.cnName = @"腿骨";
    bones.enName = @"leg";
    bones.redPointRect = CGRectMake(105, 352, 3, 3);
    bones.buttonRect = CGRectMake(38 + 30,  - 37, 70, 26);
    bones.lineStartPoint = CGPointMake(CGRectGetMinX(bones.redPointRect), CGRectGetMinY(bones.redPointRect));
    bones.lineBreakPoint = CGPointMake(38, - 37);
    bones.lineEndPoint = CGPointMake(38 + 30, - 37);
    bones.alignment = BonesAlignmentRight;
    [bonesArray addObject:bones];
    // 77 75
    return bonesArray;
}

+ (void)configureLayoutForBones:(Bones *)bones {
    
}

@end
