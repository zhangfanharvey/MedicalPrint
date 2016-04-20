//
//  Bones.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Bones : NSObject

@property (nonatomic, strong) NSString *p_ID;
@property (nonatomic, strong) NSString *cnName;
@property (nonatomic, strong) NSString *enName;

@property (nonatomic, assign) CGRect buttonRect;
@property (nonatomic, assign) CGRect redPointRect;
@property (nonatomic, assign) CGPoint lineStartPoint;
@property (nonatomic, assign) CGPoint lineBreakPoint;
@property (nonatomic, assign) CGPoint lineEndPoint;


@end
