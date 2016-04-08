//
//  MedicalHelpCollectionViewCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class CaseType;

@interface MedicalHelpCollectionViewCell : BaseCollectionViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;

- (void)configureWithCaseType:(CaseType *)caseType;

@end
