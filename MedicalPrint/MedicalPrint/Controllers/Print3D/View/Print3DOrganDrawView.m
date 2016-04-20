//
//  Print3DOrganDrawView.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "Print3DOrganDrawView.h"
#import "MajorOrganPositionManager.h"
#import "Bones.h"
#import "OrganButton.h"
@import AVFoundation;


@interface Print3DOrganDrawView ()

@property (nonatomic, strong) NSMutableArray *bonesButtonArray;
@property (nonatomic, strong) NSMutableArray *redImageViewArray;
@property (nonatomic, assign) CGRect bonesImageViewFrame;
@property (nonatomic, strong) UIImage *bonesImage;


@end

@implementation Print3DOrganDrawView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.bonesImage = [UIImage imageNamed:@"pringt_3d_骨骼"];
        
        self.bonesImageView = [[UIImageView alloc] init];
        self.bonesImageView.image = self.bonesImage;
        self.bonesImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.bonesImageView];

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    for (Bones *bones in self.bonesArray) {
        CGPoint endPoint = [self convertPoint:bones.lineEndPoint fromView:self.bonesImageView];
        [self drawPathFromStartPoint:bones.lineStartPoint breakPoint:bones.lineBreakPoint endPoint:endPoint];
    }
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger index = 0;
    for (UIButton *button in self.bonesButtonArray) {
        Bones *bones = [self.bonesArray objectAtIndex:button.tag];
        button.frame = bones.buttonRect;
        button.tag = index;
        index++;
    }
    
    for (UIImageView *imageView in self.redImageViewArray) {
        Bones *bones = [self.bonesArray objectAtIndex:imageView.tag];
        CGRect redImageViewFrame = [self convertRect:bones.redPointRect fromView:self.bonesImageView];
        imageView.frame = redImageViewFrame;
    }
    
    UIImage *image = self.bonesImage;
    self.bonesImageViewFrame = AVMakeRectWithAspectRatioInsideRect(image.size, self.bounds);
    self.bonesImageView.frame = self.bonesImageViewFrame;

}

- (void)setBonesArray:(NSArray *)bonesArray {
    _bonesArray = bonesArray;
    [self.bonesButtonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.redImageViewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self.bonesButtonArray removeAllObjects];
    [self.redImageViewArray removeAllObjects];
    NSUInteger index = 0;
    for (Bones *bones in bonesArray) {
        UIButton *button = [self createBonesButtonFor:bones];
        button.frame = bones.buttonRect;
        button.tag = index;
        [self addSubview:button];
        [self.bonesButtonArray addObject:button];
        
        UIImageView *redImageView = [[UIImageView alloc] init];
        redImageView.frame = bones.redPointRect;
        redImageView.tag = index;
        [self addSubview:redImageView];
        [self.redImageViewArray addObject:redImageView];
        index++;
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (UIButton *)createBonesButtonFor:(Bones *)bones {
    OrganButton *button = [[OrganButton alloc] init];
    button.organCNNameLabel.text = bones.cnName;
    button.organENNameLabel.text = bones.enName;
    return button;
}

- (void)drawPathFromStartPoint:(CGPoint)startPoint breakPoint:(CGPoint)breakPoint endPoint:(CGPoint)endPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:breakPoint];
    [path addLineToPoint:endPoint];
    path.lineWidth = 1;
    [[UIColor blueColor] setStroke];
    [path stroke];
}

#pragma mark - IBAction

- (IBAction)bonesButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(print3DOrganDrawView:didClickedButtonAtIndex:)]) {
        [self.delegate print3DOrganDrawView:self didClickedButtonAtIndex:button.tag];
    }
}



@end
