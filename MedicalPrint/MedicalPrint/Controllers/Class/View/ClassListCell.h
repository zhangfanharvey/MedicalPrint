//
//  ClassListCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ClassListCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *statusImageView;
@property (nonatomic, strong) UILabel *orderIDLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;

@end
