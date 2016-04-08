//
//  MedicalCaseDetailController.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/5.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseViewController.h"

@class MedicalCase;

@interface MedicalCaseDetailController : BaseViewController

- (instancetype)initWithMedicalCase:(MedicalCase *)medicalCase;

@end
