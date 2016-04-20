// UIImage+Resize.h
// Created by Trevor Harmon on 8/5/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

#import <UIKit/UIKit.h>

// Extends the UIImage class to support resizing/cropping
@interface UIImage (Resize)

- (UIImage *)mergeImage:(UIImage *)image withRect:(CGRect)rect;
- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageLetterThan:(CGSize)newSize;

- (NSData *)resizedThumbImageData:(CGSize)newSize lessThan:(CGFloat)dataLength; //bit size

- (CGRect)centerRectForDisplay;

- (UIImage*) generalResizableImageWithCapInsets:(UIEdgeInsets)capInsets;
- (UIImage*) generalResizableImageWithCenter;

+ (UIImage *)yn_imageWithColor:(UIColor *)color;

+ (UIImage *)yn_createBubbleImage:(UIImage *)image;

+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;


@end
