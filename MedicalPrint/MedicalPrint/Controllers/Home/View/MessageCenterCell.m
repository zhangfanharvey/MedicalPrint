//
//  MessageCenterCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MessageCenterCell.h"
#import "Masonry.h"

@implementation MessageCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.detailLabel];
        
        self.createTimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.createTimeLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(15);
        make.width.lessThanOrEqualTo(@200);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_top);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(15);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
}

- (void)configureWithMessage:(Message *)message {
    
}


@end
