//
//  TagSexSelectCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/7.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TagSexSelectCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIImageView *secondImageView;
@property (nonatomic, strong) UIButton *firstButton;
@property (nonatomic, strong) UIButton *secondButton;

- (void)selectMale:(BOOL)male;

@end
