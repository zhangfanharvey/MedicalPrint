//
//  IconLableTableViewCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@interface IconLabelTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *label;

@end
