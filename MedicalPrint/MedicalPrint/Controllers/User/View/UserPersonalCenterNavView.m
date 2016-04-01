//
//  UserPersonalCenterNavView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserPersonalCenterNavView.h"
#import "Masonry.h"

@implementation UserPersonalCenterNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backButton = [[UIButton alloc] init];
        [self addSubview:self.backButton];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(10);
        make.centerY.equalTo(superView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
        make.left.equalTo(self.backButton.mas_right).offset(10);
    }];
    
}

@end
