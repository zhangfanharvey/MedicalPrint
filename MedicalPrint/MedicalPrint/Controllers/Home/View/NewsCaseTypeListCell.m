//
//  NewsCaseTypeListCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "NewsCaseTypeListCell.h"
#import "Masonry.h"
#import "NewsType.h"

@implementation NewsCaseTypeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.label];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.and.height.equalTo(@45);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.centerY.equalTo(superView.mas_centerY);
        make.right.equalTo(superView.mas_right).offset(15);
    }];
}

- (void)configureWithCaseType:(NewsType *)newsType {
    if (newsType) {
        self.iconImageView.image = [UIImage imageNamed:[newsType iconImageName]];
        self.label.text = newsType.name;
    }
}

@end
