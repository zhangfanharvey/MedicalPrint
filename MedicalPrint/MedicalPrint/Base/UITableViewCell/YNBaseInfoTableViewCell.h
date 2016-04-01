//
//  YNBaseInfoTableViewCell.h
//  YNSocial
//
//  Created by Youni.Zhangfan on 3/3/15.
//  Copyright (c) 2015 Youni.Zhangfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNBaseInfoTableViewCell : UITableViewCell

+ (NSString *)cellIdentifier;

@property (nonatomic, strong) UILabel *infoLabel;

@end
