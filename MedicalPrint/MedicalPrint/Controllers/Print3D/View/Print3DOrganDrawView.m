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
        
        self.redImageViewArray = [[NSMutableArray alloc] init];
        self.bonesButtonArray = [[NSMutableArray alloc] init];
        
        self.bonesImage = [UIImage imageNamed:@"pringt_3d_骨骼"];
        
        self.bonesImageView = [[UIImageView alloc] init];
//        self.bonesImageView.backgroundColor = [UIColor blackColor];
        self.bonesImageView.image = self.bonesImage;
//        self.bonesImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.bonesImageView];
        [self sendSubviewToBack:self.bonesImageView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    for (Bones *bones in self.bonesArray) {
//        CGPoint endPoint = [self convertPoint:bones.lineEndPoint fromView:self.bonesImageView];
//        CGPoint endPoint = bones.lineEndPoint;

//        UIImage *image = self.bonesImage;
//        CGRect imageFrame = AVMakeRectWithAspectRatioInsideRect(image.size, CGRectMake(0, 12, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 24));
//        imageFrame.origin.y = 12;

        CGPoint lineStartPoint = bones.lineStartPoint;
        
        lineStartPoint.y = CGRectGetHeight(self.bonesImageViewFrame) * lineStartPoint.y / 427.0f;
//        lineStartPoint.y += CGRectGetMinY(self.bonesImageViewFrame);
        CGFloat x = lineStartPoint.x;
        lineStartPoint = [self convertPoint:lineStartPoint fromView:self.bonesImageView];
        lineStartPoint.x = x;
        
        CGPoint lineBreakPoint = bones.lineBreakPoint;
        
        lineBreakPoint.y = CGRectGetHeight(self.bonesImageViewFrame) * lineBreakPoint.y / 427.0f;
//        lineBreakPoint.y += CGRectGetMinY(self.bonesImageViewFrame);
        x = lineBreakPoint.x;
        lineBreakPoint = [self convertPoint:lineBreakPoint fromView:self.bonesImageView];
        lineBreakPoint.x = x;

        CGPoint lineEndPoint = bones.lineEndPoint;
        lineEndPoint.y = CGRectGetHeight(self.bonesImageViewFrame) * lineEndPoint.y / 427.0f;
        lineEndPoint.x = CGRectGetWidth(self.bonesImageViewFrame) * lineEndPoint.x / 184.0f;
//        x = lineEndPoint.x;
        lineEndPoint = [self convertPoint:lineEndPoint fromView:self.bonesImageView];
//        lineEndPoint.x = x;

        
        [self drawPathFromStartPoint:lineStartPoint breakPoint:lineBreakPoint endPoint:lineEndPoint];
    }
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger index = 0;
    
    UIImage *image = self.bonesImage;
    CGRect imageFrame = AVMakeRectWithAspectRatioInsideRect(image.size, CGRectMake(0, 12, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - 24));
    imageFrame.origin.y = 12;
    self.bonesImageViewFrame = imageFrame;
    self.bonesImageView.frame = self.bonesImageViewFrame;

    for (UIButton *button in self.bonesButtonArray) {
        Bones *bones = [self.bonesArray objectAtIndex:button.tag];
        CGRect buttonFrame = bones.buttonRect;
        
//        frame.origin.x = CGRectGetWidth(self.bonesImageViewFrame) * frame.origin.x / 184.0f;
        buttonFrame.origin.y = CGRectGetHeight(self.bonesImageViewFrame) * buttonFrame.origin.y / 427.0f;
        CGFloat x = buttonFrame.origin.x;
        buttonFrame = [self convertRect:buttonFrame fromView:self.bonesImageView];
        buttonFrame.origin.x = x;
        
        button.frame = buttonFrame;
        button.tag = index;
        index++;
    }

    for (UIImageView *imageView in self.redImageViewArray) {
        Bones *bones = [self.bonesArray objectAtIndex:imageView.tag];
        CGRect redImageViewFrame = bones.redPointRect;
        redImageViewFrame.origin.x = CGRectGetWidth(self.bonesImageViewFrame) * redImageViewFrame.origin.x / 184.0f;
        redImageViewFrame.origin.y = CGRectGetHeight(self.bonesImageViewFrame) * redImageViewFrame.origin.y / 427.0f;

        redImageViewFrame = [self convertRect:redImageViewFrame fromView:self.bonesImageView];
        imageView.frame = redImageViewFrame;
    }
    

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
        redImageView.image = [UIImage imageNamed:@"pringt_3d_标记点"];
        redImageView.frame = bones.redPointRect;
        redImageView.tag = index;
        [self addSubview:redImageView];
        [self.redImageViewArray addObject:redImageView];
        index++;
    }
//    [self setNeedsLayout];
//    [self setNeedsDisplay];
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
    [[UIColor colorWithRed:0.392 green:0.725 blue:0.843 alpha:1.00] setStroke];
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
