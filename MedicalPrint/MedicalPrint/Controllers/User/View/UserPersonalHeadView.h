//
//  UserPersonalHeadView.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserPersonalHeadView;

@protocol UserPersonalHeadViewDelegate <NSObject>

- (void)personalHeadView:(UserPersonalHeadView *)headView didClickedAvatarView:(UIImageView *)avatarView;

@end

@interface UserPersonalHeadView : UIView

@property (nonatomic, weak) id <UserPersonalHeadViewDelegate> delegate;

@property (nonatomic, strong) UIImageView *backGroundImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;


@end
