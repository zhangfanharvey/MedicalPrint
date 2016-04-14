//
//  MedicalHelpCollectionViewCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalHelpCollectionViewCell.h"
#import "Masonry.h"
#import "CaseType.h"

@implementation MedicalHelpCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];

        [self setupViewConstraints];

    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.mas_centerY);
        make.left.equalTo(superView.mas_left).offset(10);
        make.width.equalTo(@52);
        make.height.equalTo(@49);
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.centerY.equalTo(superView.mas_centerY);
        make.right.equalTo(superView.mas_right).offset(-4);
    }];
}

- (void)configureWithCaseType:(CaseType *)caseType {
    if (caseType.icon && caseType.icon.length > 0) {
        self.iconImageView.image = [UIImage imageNamed:caseType.icon];
    } else {
        self.iconImageView.image = [UIImage imageNamed:@"手臂_常态"];
    }
    self.nameLabel.text = caseType.name;
}

@end
