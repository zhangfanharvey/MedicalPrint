//
//  TagInputView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "TagInputView.h"
#import "EdgeInputTextField.h"
#import "Masonry.h"
#import "UIImage+Resize.h"

@implementation TagInputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagLabel = [[UILabel alloc] init];
        [self addSubview:self.tagLabel];
        
        self.inputTextField = [[EdgeInputTextField alloc] init];
        [self.inputTextField setBackground:[[UIImage imageNamed:@"注册界面输入框1"] generalResizableImageWithCenter]];
        [self addSubview:self.inputTextField];
        
        UIView *superView = self;
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@55);
            make.leading.equalTo(superView.mas_leading).offset(30);
            make.trailing.equalTo(self.inputTextField.mas_leading).offset(-15);
            make.baseline.equalTo(self.inputTextField.mas_baseline);
            make.centerX.equalTo(superView.mas_centerX);
        }];
        
        [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(superView.mas_trailing).offset(-30);
            make.height.equalTo(@45);
        }];
        
    }
    return self;
}


@end
