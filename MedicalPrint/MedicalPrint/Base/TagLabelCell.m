//
//  TagLabelCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "TagLabelCell.h"
#import "Masonry.h"

@implementation TagLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tagLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.tagLabel];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        
        self.textField = [[UITextField alloc] init];
        self.textField.hidden = YES;
        [self.contentView addSubview:self.textField];
        
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.lessThanOrEqualTo(@90);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(120);
        make.centerY.equalTo(superView.mas_centerY);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label.mas_left);
        make.centerY.equalTo(superView.mas_centerY);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
}


@end