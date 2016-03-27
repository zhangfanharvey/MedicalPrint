//
//  MedicalHelpController.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "MedicalHelpController.h"

@interface MedicalHelpController ()

@end

@implementation MedicalHelpController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"病例求助";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"病理求助_常态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"病理求助_按下"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(4.5, 0, -7, 0);
        self.tabBarItem = tabBarItem;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
