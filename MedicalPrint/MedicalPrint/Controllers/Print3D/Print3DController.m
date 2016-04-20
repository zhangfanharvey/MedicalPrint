//
//  Pringt3DController.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "Print3DController.h"
#import "UserInfoRequest.h"
#import "Print3DItemView.h"
#import "Masonry.h"
#import "OrganButton.h"
#import "MajorOrganPositionManager.h"
#import "Print3DOrganDrawView.h"

@interface Print3DController () <Print3DOrganDrawViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
//@property (nonatomic, strong) UIImageView *bonesImageView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) NSMutableArray *majorBonesArray;
@property (nonatomic, strong) Print3DOrganDrawView *drawView;

@end

@implementation Print3DController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"3D打印";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"3D打印_常态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"3D打印_按下"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 50);
        self.tabBarItem = tabBarItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backgroundImageView = [[UIImageView alloc] init];
//    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.image = [UIImage imageNamed:@"pringt_3d_底图"];
    [self.view addSubview:self.backgroundImageView];
    
//    self.bonesImageView = [[UIImageView alloc] init];
//    self.bonesImageView.image = [UIImage imageNamed:@"pringt_3d_骨骼"];
//    self.bonesImageView.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:self.bonesImageView];
    
    self.drawView = [[Print3DOrganDrawView alloc] init];
    [self.view addSubview:self.drawView];
    
    [self setupViewConstraints];
    
    
    [self initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - private

- (void)setupViewConstraints {
    UIView *superView = self.view;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    
//    CGRect frame = self.view.bounds;
//    UIImage *image = [UIImage imageNamed:@"pringt_3d_骨骼"];
//    CGFloat scaleX = image.size.width / CGRectGetWidth(frame);
//    CGFloat scaleY = image.size.height / (CGRectGetHeight(frame) - 44 - 64 - 25);
//    CGFloat scale = MAX(scaleX, scaleY);
    
//    CGFloat height = image.size.height / scale;
//    CGFloat width = image.size.width / scale;
    
//    [self.bonesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(superView);
//        make.width.equalTo([NSNumber numberWithFloat:width]);
//        make.height.equalTo([NSNumber numberWithFloat:height]);
//    }];
//    [self.bonesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.and.bottom.equalTo(superView);
//        make.top.equalTo(self.mas_topLayoutGuideBottom);
//    }];
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundImageView);
    }];
    
}

- (void)initDataSource {
    self.majorBonesArray = [MajorOrganPositionManager createMajorBones];
    self.drawView.bonesArray = self.majorBonesArray;
}

- (void)createItemsView {
    
}

#pragma mark - Print3DOrganDrawViewDelegate

- (void)print3DOrganDrawView:(Print3DOrganDrawView *)drawView didClickedButtonAtIndex:(NSInteger)index {
    Bones *bones = [self.majorBonesArray objectAtIndex:index];
    if (bones) {
        ;
    }
}

@end
