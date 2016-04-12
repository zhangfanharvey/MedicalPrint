//
//  OrderListCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "OrderListCell.h"
#import "Masonry.h"
#import "Order.h"

@implementation OrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor colorWithRed:0.314 green:0.318 blue:0.322 alpha:1.00];
        self.nameLabel.font = [UIFont systemFontOfSize:kBigCellFontSize];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusImageView = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.statusImageView];
        
        self.orderIDLabel = [[UILabel alloc] init];
        self.orderIDLabel.font = [UIFont systemFontOfSize:kBigCellFontSize];
        self.orderIDLabel.textColor = [UIColor colorWithRed:0.318 green:0.322 blue:0.325 alpha:1.00];
        [self.contentView addSubview:self.orderIDLabel];
        
        self.createTimeLabel = [[UILabel alloc] init];
        self.createTimeLabel.font = [UIFont systemFontOfSize:kLittleCellFontSize];
        self.createTimeLabel.textColor = [UIColor colorWithRed:0.596 green:0.600 blue:0.604 alpha:1.00];
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
//        make.bottom.equalTo(self.nameLabel.mas_bottom);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.left.equalTo(self.nameLabel.mas_right).offset(10);
        make.width.equalTo(@38);
        make.height.equalTo(@15);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView.mas_right).offset(-15);
        make.top.equalTo(self.nameLabel.mas_top);
        make.left.greaterThanOrEqualTo(self.statusImageView.mas_right).offset(10);
    }];
    
    [self.orderIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.bottom.equalTo(superView.mas_bottom).offset(-15);
        make.right.lessThanOrEqualTo(superView.mas_right);
    }];
}

- (void)configureWithOrder:(Order *)order {
    if (order) {
        self.nameLabel.text = order.name;
        self.createTimeLabel.text = order.createTimeStr;
        self.orderIDLabel.text = [NSString stringWithFormat:@"%@", order.p_ID];
        self.statusImageView.image = [UIImage imageNamed:[order orderStatusImageName]];
    } else {
        [self configureWithFakeData];
    }
}

- (void)configureWithFakeData {
    self.nameLabel.text = @"test";
    self.createTimeLabel.text = @"2013-20";
    self.orderIDLabel.text = [NSString stringWithFormat:@"%@", @"2323232"];
    self.statusImageView.image = [UIImage imageNamed:@"未完成"];

}


@end
