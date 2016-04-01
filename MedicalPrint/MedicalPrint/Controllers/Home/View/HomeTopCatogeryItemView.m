//
//  HomeTopCatogeryItemView.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "HomeTopCatogeryItemView.h"
#import "Masonry.h"

@implementation HomeTopCatogeryItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageButton = [[UIButton alloc] init];
        [self addSubview:self.iconImageButton];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
        [self setupViewConstraints];
    }
    return self;
}


#pragma mark - view constraints

- (void)setupViewConstraints {
    UIView *superView = self;
    [self.iconImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(10);
        make.centerX.equalTo(superView.mas_centerX);
        make.width.and.height.equalTo(@50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageButton.mas_bottom).offset(5);
        make.left.and.right.equalTo(superView);
    }];
}


@end
