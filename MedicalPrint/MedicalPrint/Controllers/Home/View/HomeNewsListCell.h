//
//  HomeNewsListCell.h
//  MedicalPrint
//
//  Created by zhangfan on 16/3/28.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "BaseTableViewCell.h"

@class News;

@interface HomeNewsListCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

- (void)configureWithNews:(News *)news;

@end
