//
//  AddressManagerCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/24.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "AddressManagerCell.h"
#import "Masonry.h"

/*
 @property (nonatomic, strong) UILabel *nickNameLabel;
 @property (nonatomic, strong) UILabel *phoneLabel;
 @property (nonatomic, strong) UILabel *cityLabel;
 @property (nonatomic, strong) UILabel *zipCodeLabel;
 @property (nonatomic, strong) UILabel *locationLabel;
 @property (nonatomic, strong) UIButton *editButton;
 @property (nonatomic, strong) UIButton *delegateButton;
*/
@implementation AddressManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nickNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nickNameLabel];
        
        self.phoneLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.phoneLabel];
        
        self.cityLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.cityLabel];
        
        self.zipCodeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.zipCodeLabel];

        self.locationLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.locationLabel];

        self.editButton = [[UIButton alloc] init];
        [self.contentView addSubview:self.editButton];
        
        self.deleteButton = [[UIButton alloc] init];
        [self.contentView addSubview:self.deleteButton];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(15);
        make.width.lessThanOrEqualTo(@260);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(5);
        make.right.equalTo(self.editButton.mas_right).offset(-10);
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(15);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
}

@end
