//
//  TagInputView.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EdgeInputTextField;

@interface TagInputView : UIView

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) EdgeInputTextField *inputTextField;

@end
