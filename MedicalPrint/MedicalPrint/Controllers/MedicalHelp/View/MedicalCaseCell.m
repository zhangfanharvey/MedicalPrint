//
//  MedicalCaseCell.m
//  MedicalPrint
//
//  Created by zhang fan on 4/4/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "MedicalCaseCell.h"
#import "Masonry.h"
#import "MedicalCase.h"

@implementation MedicalCaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.font = [UIFont systemFontOfSize:13];
        self.detailLabel.textColor = [UIColor colorWithRed:0.596 green:0.600 blue:0.604 alpha:1.00];
        [self.contentView addSubview:self.detailLabel];

        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = [UIColor colorWithRed:0.596 green:0.600 blue:0.604 alpha:1.00];
        [self.contentView addSubview:self.timeLabel];
        
        [self setupViewConstraints];

    }
    return self;
}

#pragma mark - View Auto-Layout

- (void)setupViewConstraints
{
    UIView *superView = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_top);
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.bottom.lessThanOrEqualTo(superView.mas_bottom).offset(-4);
    }];
}

- (void)configureWithMedicalCase:(MedicalCase *)medicalCase {
    self.titleLabel.text = medicalCase.title;
    self.timeLabel.text = medicalCase.createTimeLong;
    self.detailLabel.text = medicalCase.content;
    [self configureFakeData];
}

- (void)configureFakeData {
    self.titleLabel.text = @"medicalCase.title";
    self.timeLabel.text = @"12-1";
    self.detailLabel.text = @"medicalCase.content medicalCase.content medicalCase.content medicalCase.content medicalCase.content medicalCase.content";
}


@end
