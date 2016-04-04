//
//  YNBaseInfoTableViewCell.m
//  YNSocial
//
//  Created by Youni.Zhangfan on 3/3/15.
//  Copyright (c) 2015 Youni.Zhangfan. All rights reserved.
//

#import "YNBaseInfoTableViewCell.h"

@implementation YNBaseInfoTableViewCell

+ (NSString *)cellIdentifier
{
    static NSString *baseInfoTableViewCellIdentifer = @"YNBaseInfoTableViewCellIdentifier";
    return baseInfoTableViewCellIdentifer;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.infoLabel = [[UILabel alloc] init];
        self.infoLabel.font = [UIFont systemFontOfSize:kCommonCellFontSize];
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = NO;

        [self.contentView addSubview:self.infoLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

#pragma mark - View Auto-Layout

- (void)setupViewConstraints
{
    NSDictionary *views = @{@"infoLabel": self.infoLabel,
                            };
    
    NSDictionary *metrics = @{
                              };
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[infoLabel]-35-|" options:0 metrics:metrics views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[infoLabel]|" options:0 metrics:metrics views:views]];
}

@end
