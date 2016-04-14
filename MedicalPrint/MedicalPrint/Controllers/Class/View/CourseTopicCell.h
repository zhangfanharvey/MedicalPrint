//
//  CourseTopicCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/4/14.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@class CourseTopic;

@interface CourseTopicCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

- (void)configureWithCourseTopic:(CourseTopic *)topic;

@end
