//
//  MedicalCaseDetailCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/5.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalCaseDetailCell.h"
#import "Masonry.h"
#import "MedicalCase.h"

@implementation MedicalCaseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatarImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.avatarImageView];
        
        self.nickNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nickNameLabel];
        
        self.positionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.positionLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(10);
        make.width.and.height.equalTo(@65);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(6);
        make.top.equalTo(self.avatarImageView.mas_top);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_top);
        make.left.equalTo(self.nickNameLabel.mas_right).offset(4);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_top);
        make.left.equalTo(self.positionLabel.mas_right).offset(10);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(8);
        make.left.equalTo(self.avatarImageView);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
    }];
}

@end
