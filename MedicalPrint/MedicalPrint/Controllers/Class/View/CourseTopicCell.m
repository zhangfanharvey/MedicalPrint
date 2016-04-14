//
//  CourseTopicCell.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/14.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "CourseTopicCell.h"
#import "Masonry.h"
#import "CourseTopic.h"
#import "UIImageView+WebCache.h"

@implementation CourseTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newsImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.newsImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.numberOfLines = 0;
        [self.contentView addSubview:self.detailLabel];
        
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self.contentView;
    
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(10);
        make.centerY.equalTo(superView.mas_centerY);
        make.width.and.height.equalTo(@60);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(superView.mas_right).offset(-15);
        make.top.equalTo(self.newsImageView.mas_top);
        make.left.equalTo(self.newsImageView.mas_right).offset(10);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.equalTo(superView.mas_bottom).offset(-8);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
}

- (void)configureWithCourseTopic:(CourseTopic *)topic {
    [self.newsImageView sd_setImageWithURL:[NSURL URLWithString:[topic iconImageUrl]] placeholderImage:nil];
    self.titleLabel.text = topic.title;
    self.detailLabel.text = topic.content;
}

@end
