//
//  YNBaseSwitchTableViewCell.m
//  YNSocial
//
//  Created by Youni.Zhangfan on 3/3/15.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "YNBaseSwitchTableViewCell.h"

@implementation YNBaseSwitchTableViewCell

+ (NSString *)cellIdentifier {
    static NSString *baseSwitchTableViewCellIdentifier = @"baseSwitchTableViewCellIdentifier";
    return baseSwitchTableViewCellIdentifier;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.tagLabel.font = [UIFont systemFontOfSize:kCommonCellFontSize];
        [self.contentView addSubview:self.tagLabel];
        
        self.switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        self.switchView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.switchView];
        
        [self.switchView addTarget:self action:@selector(switchValueDidChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self setupViewConstraints];
    }
    return self;
}

#pragma mark - View Auto-Layout

- (void)setupViewConstraints
{
    NSDictionary *views = @{@"tagLabel": self.tagLabel,
                            @"switchView": self.switchView,
                            };
    
    NSDictionary *metrics = @{
                              };
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[tagLabel]-(>=0)-[switchView]-15-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tagLabel]|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.switchView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0]];
}

#pragma mark - IBAction

- (void)switchValueDidChanged:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didChangedSwitchTalbleViewCell:switchView:)]) {
        [self.delegate didChangedSwitchTalbleViewCell:self switchView:self.switchView];
    }
}

@end
