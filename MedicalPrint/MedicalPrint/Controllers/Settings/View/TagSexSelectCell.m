//
//  TagSexSelectCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/7.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "TagSexSelectCell.h"
#import "Masonry.h"

@implementation TagSexSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tagLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.tagLabel];
        
        self.firstLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.firstLabel];

        self.secondLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.secondLabel];
        
        self.firstImageView = [[UIImageView alloc] init];
        self.firstImageView.image = [UIImage imageNamed:@"address_女士"];
        [self.contentView addSubview:self.firstImageView];
        
        self.secondImageView = [[UIImageView alloc] init];
        self.firstImageView.image = [UIImage imageNamed:@"address_女士"];
        [self.contentView addSubview:self.secondImageView];

        self.firstButton = [[UIButton alloc] init];
        [self.contentView addSubview:self.firstButton];
        
        self.secondButton = [[UIButton alloc] init];
        [self.contentView addSubview:self.secondButton];
        
        [self setupViewConstraints];

    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.equalTo(@90);
    }];
    
    [self.firstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.firstLabel.mas_left).offset(-10);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.and.height.equalTo(@30);
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.secondImageView.mas_left).offset(-10);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.equalTo(@35);
    }];

    [self.secondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.secondLabel.mas_left).offset(-10);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.and.height.equalTo(@30);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-10);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.equalTo(@35);
    }];
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstImageView.mas_left).offset(-10);
        make.right.equalTo(self.firstLabel.mas_right).offset(10);
        make.height.equalTo(@45);
    }];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondImageView.mas_left).offset(-10);
        make.right.equalTo(self.secondLabel.mas_right).offset(10);
        make.height.equalTo(@45);
    }];

    
}

- (void)selectMale:(BOOL)male {
    if (male) {
        self.firstImageView.image = [UIImage imageNamed:@"address_先生"];
        self.secondImageView.image = [UIImage imageNamed:@"address_女士"];
    } else {
        self.secondImageView.image = [UIImage imageNamed:@"address_先生"];
        self.firstImageView.image = [UIImage imageNamed:@"address_女士"];
    }
}

@end
