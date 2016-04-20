//
//  Print3DOrganDrawView.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Print3DOrganDrawView;

@protocol Print3DOrganDrawViewDelegate <NSObject>

- (void)print3DOrganDrawView:(Print3DOrganDrawView *)drawView didClickedButtonAtIndex:(NSInteger)index;

@end

@interface Print3DOrganDrawView : UIView

@property (nonatomic, weak) id<Print3DOrganDrawViewDelegate> delegate;

@property (nonatomic, strong) NSArray *bonesArray;

@property (nonatomic, strong) UIImageView *bonesImageView;


@end
