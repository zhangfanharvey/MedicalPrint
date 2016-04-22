//
//  MedicalCaseDetailCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/5.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MedicalCase;

@interface MedicalCaseDetailCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)configureWithMedicalCase:(MedicalCase *)medicalCase;

@end
