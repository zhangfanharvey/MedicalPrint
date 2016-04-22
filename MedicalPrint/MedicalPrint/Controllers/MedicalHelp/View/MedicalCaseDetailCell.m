//
//  MedicalCaseDetailCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/5.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalCaseDetailCell.h"
#import "Masonry.h"
#import "MedicalCase.h"
#import "UIImageView+WebCache.h"

#define kMedicalCaseDetailCellAvatarHeight 65

@interface MedicalCaseDetailCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation MedicalCaseDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.backgroundColor = [UIColor grayColor];
        self.avatarImageView.layer.cornerRadius = kMedicalCaseDetailCellAvatarHeight / 2.0f;
        self.avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avatarImageView];
        
        self.nickNameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nickNameLabel];
        
        self.positionLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.positionLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.timeLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
//        [self setupViewConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        self.contentView.bounds = CGRectMake(0, 0, 999, 999);

        self.didSetupConstraints = YES;
        [self setupViewConstraints];
    }
    [super updateConstraints];
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(10);
        make.width.and.height.equalTo(@kMedicalCaseDetailCellAvatarHeight);
//        make.bottom.equalTo(superView.mas_bottom).offset(-15);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).offset(6);
        make.top.equalTo(self.avatarImageView.mas_top);
//        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_top);
        make.left.equalTo(self.nickNameLabel.mas_right).offset(4);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_top);
        make.left.equalTo(self.positionLabel.mas_right).offset(10);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(8);
        make.left.equalTo(self.avatarImageView.mas_left);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.bottom.equalTo(superView.mas_bottom).offset(-10);
    }];
}

- (void)configureWithMedicalCase:(MedicalCase *)medicalCase {
    if (medicalCase) {
//        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:medicalCase.] placeholderImage:nil];
        self.nickNameLabel.text = medicalCase.nickname;
        self.positionLabel.text = medicalCase.position;
        self.timeLabel.text = [TimeManager timeStringFromInterval:medicalCase.createTimeLong];
        self.contentLabel.text = medicalCase.content;
    }
}

@end
