//
//  NewsListController.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseViewController.h"

@class NewsType;

@interface NewsListController : BaseViewController

- (instancetype)initWithCaseType:(NewsType *)newsType;

@end
