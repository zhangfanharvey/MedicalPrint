//
//  Print3DItemView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/1.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Print3DItemView.h"
#import "Masonry.h"

@implementation Print3DItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        [self addSubview:self.detailLabel];
        
        self.actionButton = [[UIButton alloc] init];
        [self addSubview:self.actionButton];
        
        [self setupViewConstraints];
    }
    return self;
}

#pragma mark - private

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.top.equalTo(superView.mas_top).offset(4);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.top.equalTo(self.titleLabel.mas_top).offset(4);
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];

}

@end
