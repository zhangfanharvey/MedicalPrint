//
//  IconLableTableViewCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "IconLableTableViewCell.h"
#import "Masonry.h"

@implementation IconLableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.and.height.equalTo(@30);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(superView.mas_centerY);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
}



@end
