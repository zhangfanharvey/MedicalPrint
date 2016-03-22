//
//  YNBaseSwitchTableViewCell.h
//  YNSocial
//
//  Created by Youni.Zhangfan on 3/3/15.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YNBaseSwitchTableViewCell;

@protocol YNBaseSwitchTableViewCellDelegate <NSObject>

- (void)didChangedSwitchTalbleViewCell:(YNBaseSwitchTableViewCell *)cell switchView:(UISwitch *)switchButton;

@end

@interface YNBaseSwitchTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;

@property (nonatomic, weak) id<YNBaseSwitchTableViewCellDelegate> delegate;

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UISwitch *switchView;

@end
