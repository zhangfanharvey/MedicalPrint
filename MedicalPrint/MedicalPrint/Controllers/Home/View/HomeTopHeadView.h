//
//  HomeTopHeadView.h
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeTopCatogeryItemView;
@class SDCycleScrollView;
@class HomeTopHeadView;

@protocol HomeTopHeadViewDelegate <NSObject>

- (void)homeTopHeadView:(HomeTopHeadView *)topHeadView didSelectCaseTypeItemAtIndex:(NSInteger)index;

@end

@interface HomeTopHeadView : UIView

+ (CGFloat)heightForTopHeadView;

@property (nonatomic, weak) id <HomeTopHeadViewDelegate> delegate;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) HomeTopCatogeryItemView *itemView1;
@property (nonatomic, strong) HomeTopCatogeryItemView *itemView2;
@property (nonatomic, strong) HomeTopCatogeryItemView *itemView3;
@property (nonatomic, strong) HomeTopCatogeryItemView *itemView4;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *lineImageView;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButon;

- (void)configureDemoData;

- (void)configureNewsTypeWithList:(NSArray *)newsTypeArray;

- (void)configureWithAidImageUrl:(NSArray *)urlArray;


@end
