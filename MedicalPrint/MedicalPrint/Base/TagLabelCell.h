//
//  TagLabelCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TagLabelCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@end
