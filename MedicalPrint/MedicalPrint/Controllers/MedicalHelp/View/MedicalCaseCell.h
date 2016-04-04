//
//  MedicalCaseCell.h
//  MedicalPrint
//
//  Created by zhang fan on 4/4/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MedicalCase;

@interface MedicalCaseCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)configureWithMedicalCase:(MedicalCase *)medicalCase;

@end
