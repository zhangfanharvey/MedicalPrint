//
//  BarcodeView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/30.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BarcodeView.h"
#import "Masonry.h"

@implementation BarcodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.barcodeImageView = [[UIImageView alloc] init];
        [self addSubview:self.barcodeImageView];
        
        self.avatarImageView = [[UIImageView alloc] init];
        [self addSubview:self.avatarImageView];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.barcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
        make.width.equalTo(@190);
        make.height.equalTo(self.barcodeImageView.mas_width);
    }];
    
    [self.barcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView);
        make.width.equalTo(@40);
        make.height.equalTo(self.barcodeImageView.mas_width);
    }];
}

@end
