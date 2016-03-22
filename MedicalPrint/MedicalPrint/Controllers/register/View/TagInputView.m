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
        self.tagLabel.font = [UIFont systemFontOfSize:15.0f];
        self.tagLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.tagLabel];
        
        self.inputTextField = [[EdgeInputTextField alloc] init];
        self.inputTextField.font = [UIFont systemFontOfSize:16.0f];
        [self.inputTextField setBackground:[[UIImage imageNamed:@"注册界面输入框1"] generalResizableImageWithCenter]];
        [self addSubview:self.inputTextField];
        
        UIView *superView = self;
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@66);
            make.left.equalTo(superView.mas_left).offset(0);
            make.centerY.equalTo(superView.mas_centerY);
        }];
        
        [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(superView.mas_centerY);
            make.leading.equalTo(self.tagLabel.mas_trailing).offset(15);
            make.right.equalTo(superView.mas_right).offset(0);
            make.height.equalTo(@40);
        }];
        
    }
    return self;
}


@end
