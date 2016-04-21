//
//  OrganButton.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "OrganButton.h"
#import "Masonry.h"

@implementation OrganButton

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"pringt_3d_按钮_常态"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"pringt_3d_按钮_按下"] forState:UIControlStateHighlighted];
        
        self.organCNNameLabel = [[UILabel alloc] init];
        self.organCNNameLabel.textAlignment = NSTextAlignmentRight;
        self.organCNNameLabel.textColor = [UIColor whiteColor];
        self.organCNNameLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:self.organCNNameLabel];
        
        self.organENNameLabel = [[UILabel alloc] init];
        self.organENNameLabel.font = [UIFont systemFontOfSize:11];
        self.organENNameLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.organENNameLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.organCNNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(superView);
        make.right.equalTo(superView.mas_right).offset(-6);
    }];
    
    [self.organENNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(7);
        make.right.and.bottom.equalTo(superView);
    }];
}


@end
