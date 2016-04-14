//
//  SearchAutoCompleteCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/12.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "SearchAutoCompleteCell.h"
#import "Masonry.h"

@implementation SearchAutoCompleteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor colorWithRed:0.643 green:0.643 blue:0.643 alpha:1.00];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.label];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.centerY.equalTo(superView.mas_centerY);
        make.right.lessThanOrEqualTo(superView.mas_right);
    }];
}


@end
