//
//  NewsCaseTypeListCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@class NewsType;

@interface NewsCaseTypeListCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *label;

- (void)configureWithCaseType:(NewsType *)newsType;

@end
