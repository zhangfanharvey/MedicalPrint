//
//  UserPersonalHeadView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserPersonalHeadView.h"
#import "Masonry.h"

#define kUserPersonalHeadViewWidth  54

@implementation UserPersonalHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backGroundImageView = [[UIImageView alloc] init];
        self.backGroundImageView.image = [UIImage imageNamed:@"台头底图"];
        self.backGroundImageView.contentMode =0;
        [self addSubview:self.backGroundImageView];

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
//        self.nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.nameLabel];
        
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.layer.cornerRadius = kUserPersonalHeadViewWidth / 2.0f;
        self.avatarImageView.layer.masksToBounds = YES;
        self.avatarImageView.backgroundColor = [UIColor whiteColor];
        self.avatarImageView.userInteractionEnabled = YES;
//        self.avatarImageView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.avatarImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedAvatarView:)];
        [self.avatarImageView addGestureRecognizer:tapGesture];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
//        make.centerY.equalTo(superView.mas_centerY);
        make.top.equalTo(superView.mas_top).offset(44+ (180 - 44 - kUserPersonalHeadViewWidth) / 2.0f);
//        make.bottom.equalTo(self.nameLabel.mas_top).offset(-10);
        make.width.and.height.equalTo(@kUserPersonalHeadViewWidth);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.avatarImageView.mas_centerX);
//        make.top.equalTo(self.avatarImageView.mas_bottom).offset(5);
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.bottom.equalTo(superView.mas_bottom).offset(-8);
    }];
}

#pragma mark - UIGesture Handler

- (void)didClickedAvatarView:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(personalHeadView:didClickedAvatarView:)]) {
            [self.delegate personalHeadView:self didClickedAvatarView:self.avatarImageView];
        }
    }
}

@end
