//
//  HomeTopHeadView.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "HomeTopHeadView.h"
#import "HomeTopCatogeryItemView.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "NewsType.h"

@interface HomeTopHeadView () <SDCycleScrollViewDelegate>

@end

@implementation HomeTopHeadView

+ (CGFloat)heightForTopHeadView {
    CGRect screemFrame = [UIScreen mainScreen].bounds;
    CGFloat height = CGRectGetWidth(screemFrame) / 320 * 176;
    return height;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height = [[self class] heightForTopHeadView];
        SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), height) delegate:self placeholderImage:[UIImage imageNamed:@"广告大图"]];
//        cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
//        cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
//        cycleScrollView3.imageURLStringsGroup = imagesURLStrings;
//        cycleScrollView3.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        cycleScrollView3.localizationImageNamesGroup = @[@"广告大图", @"广告大图", @"广告大图"];
        cycleScrollView3.backgroundColor = [UIColor redColor];
        [self addSubview:cycleScrollView3];
        
        self.cycleScrollView = cycleScrollView3;
        
        self.itemView1 = [[HomeTopCatogeryItemView alloc] init];
        [self addSubview:self.itemView1];
        self.itemView2 = [[HomeTopCatogeryItemView alloc] init];
        [self addSubview:self.itemView2];
        self.itemView3 = [[HomeTopCatogeryItemView alloc] init];
        [self addSubview:self.itemView3];
        self.itemView4 = [[HomeTopCatogeryItemView alloc] init];
        [self addSubview:self.itemView4];
        
        self.leftLabel = [[UILabel alloc] init];
        self.leftLabel.font = [UIFont systemFontOfSize:kCommonCellFontSize];
        self.leftLabel.textColor = [UIColor colorWithRed:0.533 green:0.537 blue:0.541 alpha:1.00];
        [self addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.font = [UIFont systemFontOfSize:kCommonCellFontSize];
        self.rightLabel.textColor = [UIColor colorWithRed:0.533 green:0.537 blue:0.541 alpha:1.00];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.rightLabel];
        
        self.leftButton = [[UIButton alloc] init];
        [self addSubview:self.leftButton];
        
        self.rightButon = [[UIButton alloc] init];
        [self addSubview:self.rightButon];
        
        self.lineImageView = [[UIImageView alloc] init];
        self.lineImageView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.lineImageView];
        
        [self setupViewConstraints];

    }
    return self;
}

- (void)setupViewConstraints {
    UIView *superView = self;
    CGFloat height = [[self class] heightForTopHeadView];

    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(superView);
        make.height.equalTo(@(height));
    }];
    
    CGFloat itemHeight = 90;
    
    [self.itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(0);
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset(0);
        make.height.equalTo(@(itemHeight));
    }];
    
    [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemView1.mas_right).offset(0);
        make.top.equalTo(self.itemView1.mas_top);
        make.height.equalTo(@(itemHeight));
        make.width.equalTo(self.itemView1.mas_width);
    }];
    
    [self.itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemView2.mas_right).offset(0);
        make.top.equalTo(self.itemView1.mas_top);
        make.height.equalTo(@(itemHeight));
        make.width.equalTo(self.itemView1.mas_width);
    }];
    
    [self.itemView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemView3.mas_right).offset(0);
        make.top.equalTo(self.itemView1.mas_top);
        make.height.equalTo(@(itemHeight));
        make.width.equalTo(self.itemView1.mas_width);
        make.right.equalTo(superView.mas_right);
    }];


    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView.mas_bottom).offset(-6);
        make.left.equalTo(superView.mas_left).offset(15);
//        make.top.equalTo(self.itemView1.mas_bottom).offset(10);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftLabel.mas_right).offset(10);
        make.top.equalTo(self.leftLabel.mas_top);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.leftLabel);
        make.width.equalTo(@50);
        make.height.equalTo(@45);
    }];
    
    [self.rightButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rightLabel);
        make.width.equalTo(@50);
        make.height.equalTo(@45);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView.mas_bottom).offset(-1);
        make.left.equalTo(superView.mas_left);
        make.right.equalTo(superView.mas_right);
        make.height.equalTo(@SINGLE_LINE_WIDTH);
    }];
}

#pragma mark - private

- (void)configureDemoData {
    [self.itemView1.iconImageButton setBackgroundImage:[UIImage imageNamed:@"科研_常态"] forState:UIControlStateNormal];
    [self.itemView1.iconImageButton setBackgroundImage:[UIImage imageNamed:@"科研_按下"] forState:UIControlStateHighlighted];
    self.itemView1.nameLabel.text = @"科研";
    
    [self.itemView2.iconImageButton setBackgroundImage:[UIImage imageNamed:@"教育_常态"] forState:UIControlStateNormal];
    [self.itemView2.iconImageButton setBackgroundImage:[UIImage imageNamed:@"教育_按下"] forState:UIControlStateHighlighted];
    self.itemView2.nameLabel.text = @"教育";

    [self.itemView3.iconImageButton setBackgroundImage:[UIImage imageNamed:@"服务_常态"] forState:UIControlStateNormal];
    [self.itemView3.iconImageButton setBackgroundImage:[UIImage imageNamed:@"服务_按下"] forState:UIControlStateHighlighted];
    self.itemView3.nameLabel.text = @"服务";
    
    [self.itemView4.iconImageButton setBackgroundImage:[UIImage imageNamed:@"转化_常态"] forState:UIControlStateNormal];
    [self.itemView4.iconImageButton setBackgroundImage:[UIImage imageNamed:@"转化_按下"] forState:UIControlStateHighlighted];
    self.itemView4.nameLabel.text = @"转化";
    
    self.leftLabel.text = @"DOF Info";
    self.rightLabel.text = @"更多…";

}

- (void)configureNewsTypeWithList:(NSArray *)newsTypeArray {
    NewsType *newsType = nil;
    if (newsTypeArray.count > 0) {
        newsType = [newsTypeArray objectAtIndex:0];
        [self.itemView1.iconImageButton setBackgroundImage:[UIImage imageNamed:newsType.icon] forState:UIControlStateNormal];
        self.itemView1.nameLabel.text = newsType.name;
    }
    
    if (newsTypeArray.count > 1) {
        newsType = [newsTypeArray objectAtIndex:1];
        [self.itemView2.iconImageButton setBackgroundImage:[UIImage imageNamed:newsType.icon] forState:UIControlStateNormal];
        self.itemView2.nameLabel.text = newsType.name;
    }
    if (newsTypeArray.count > 2) {
        newsType = [newsTypeArray objectAtIndex:2];
        [self.itemView3.iconImageButton setBackgroundImage:[UIImage imageNamed:newsType.icon] forState:UIControlStateNormal];
        self.itemView3.nameLabel.text = newsType.name;
    }
    if (newsTypeArray.count > 3) {
        newsType = [newsTypeArray objectAtIndex:3];
        [self.itemView4.iconImageButton setBackgroundImage:[UIImage imageNamed:newsType.icon] forState:UIControlStateNormal];
        self.itemView4.nameLabel.text = newsType.name;
    }
    
    self.leftLabel.text = @"DOF Info";
    self.rightLabel.text = @"更多…";
}

#pragma mark - SDCycleScrollViewDelegate


@end
