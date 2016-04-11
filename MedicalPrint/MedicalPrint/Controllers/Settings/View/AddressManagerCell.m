//
//  AddressManagerCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/24.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "AddressManagerCell.h"
#import "Masonry.h"
#import "ShippingAddress.h"

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
        self.nickNameLabel.textColor = [UIColor colorWithRed:0.314 green:0.318 blue:0.322 alpha:1.00];
        [self.contentView addSubview:self.nickNameLabel];
        
        self.sexLabel = [[UILabel alloc] init];
        self.sexLabel.textColor = [UIColor colorWithRed:0.314 green:0.318 blue:0.322 alpha:1.00];
        [self.contentView addSubview:self.sexLabel];

        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.textColor = [UIColor colorWithRed:0.314 green:0.318 blue:0.322 alpha:1.00];
        [self.contentView addSubview:self.phoneLabel];
        
        self.cityLabel = [[UILabel alloc] init];
        self.cityLabel.textColor = [UIColor colorWithRed:0.592 green:0.596 blue:0.600 alpha:1.00];
        [self.contentView addSubview:self.cityLabel];
        
        self.zipCodeLabel = [[UILabel alloc] init];
        self.zipCodeLabel.textColor = [UIColor colorWithRed:0.592 green:0.596 blue:0.600 alpha:1.00];
        [self.contentView addSubview:self.zipCodeLabel];

        self.locationLabel = [[UILabel alloc] init];
        self.locationLabel.textColor = [UIColor colorWithRed:0.592 green:0.596 blue:0.600 alpha:1.00];
        [self.contentView addSubview:self.locationLabel];

        self.editButton = [[UIButton alloc] init];
        [self.editButton setImage:[UIImage imageNamed:@"address_编辑按钮_常态"] forState:UIControlStateNormal];
        [self.editButton setImage:[UIImage imageNamed:@"address_编辑按钮_按下"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:self.editButton];
        
        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton setImage:[UIImage imageNamed:@"address_删除按钮_常态"] forState:UIControlStateNormal];
        [self.deleteButton setImage:[UIImage imageNamed:@"address_删除按钮_按下"] forState:UIControlStateHighlighted];
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
        make.width.equalTo(@90);
//        make.width.lessThanOrEqualTo(@260);
    }];
    
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(74);
        make.top.equalTo(self.nickNameLabel.mas_top);
        make.right.lessThanOrEqualTo(self.editButton.mas_left).offset(-10);
    }];

    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel.mas_left);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(4);
        make.right.equalTo(self.editButton.mas_right).offset(-10);
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(8);
        make.left.equalTo(self.nickNameLabel.mas_left);
//        make.bottom.equalTo(superView.mas_bottom).offset(-10);
//        make.right.equalTo(self.zipCodeLabel.mas_left).offset(-15);
    }];
    
    [self.zipCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityLabel.mas_top);
        make.left.equalTo(self.cityLabel.mas_right).offset(20);
        make.right.lessThanOrEqualTo(self.editButton.mas_left).offset(-10);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel.mas_left);
        make.top.equalTo(self.zipCodeLabel.mas_bottom).offset(5);
        make.right.equalTo(superView.mas_right).offset(-85);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(superView.mas_top).offset(20).multipliedBy(1.0);
        make.centerY.equalTo(superView.mas_centerY).offset(-30);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.width.and.height.equalTo(@40);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(superView.mas_top).offset(20);
        make.centerY.equalTo(superView.mas_centerY).offset(20);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.width.and.height.equalTo(@40);
    }];

    
    
}

/*
 @property (nonatomic, strong) NSString *p_ID;
 @property (nonatomic, strong) NSNumber *memberId;
 @property (nonatomic, strong) NSString *name;
 @property (nonatomic, assign) NSInteger sex;
 @property (nonatomic, strong) NSString *phone;
 @property (nonatomic, strong) NSString *address;
*/

- (void)configureWithShipAddress:(ShippingAddress *)shipAddress {
    self.shipAddress = shipAddress;
    [self configureWithFakeData];
}

- (void)configureWithFakeData {
    self.nickNameLabel.text = @"name";
    self.sexLabel.text = @"sexLabel";

    self.phoneLabel.text = @"phoneLabel";
    self.cityLabel.text = @"cityLabel";
    self.zipCodeLabel.text = @"zipCodeLabel";
    self.locationLabel.text = @"locationLabel";
}

@end
