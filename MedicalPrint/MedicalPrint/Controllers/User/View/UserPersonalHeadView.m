//
//  UserPersonalHeadView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserPersonalHeadView.h"
#import "Masonry.h"

#define kUserPersonalHeadViewWidth  45

@implementation UserPersonalHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.layer.cornerRadius = kUserPersonalHeadViewWidth / 2.0f;
        self.avatarImageView.layer.masksToBounds = YES;
        [self addSubview:self.avatarImageView];
        
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.and.height.equalTo(@kUserPersonalHeadViewWidth);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarImageView.mas_centerX);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(5);
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
}


@end
