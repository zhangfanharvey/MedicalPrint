//
//  HomeTopCatogeryItemView.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "HomeTopCatogeryItemView.h"

@implementation HomeTopCatogeryItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self addSubview:self.nameLabel];
        
    }
    return self;
}

//#pragma mark - View Auto-Layout
//
//- (void)setupViewConstraints
//{
//    NSDictionary *views = @{@"scrollView": self.scrollView,
//                            };
//    
//    NSDictionary *metrics = @{
//                              };
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:0 metrics:metrics views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:metrics views:views]];
//}


@end
