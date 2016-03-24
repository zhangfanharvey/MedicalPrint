//
//  ClassListCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "ClassListCell.h"
#import "Masonry.h"

@implementation ClassListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.statusImageView];
        
        self.orderIDLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.orderIDLabel];
        
        self.createTimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.createTimeLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(15);
        make.width.lessThanOrEqualTo(@200);
    }];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nameLabel.mas_baseline);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.width.and.height.equalTo(@20);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-15);
        make.top.equalTo(self.nameLabel.mas_top);
        make.left.greaterThanOrEqualTo(self.statusImageView.mas_right).offset(10);
    }];
    
    [self.orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.bottom.equalTo(superView.mas_bottom).offset(-20);
        make.right.lessThanOrEqualTo(superView.mas_right);
    }];
    
    
    
}


@end
