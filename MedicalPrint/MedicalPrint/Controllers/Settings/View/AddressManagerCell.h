//
//  AddressManagerCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/24.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AddressManagerCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *zipCodeLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end
