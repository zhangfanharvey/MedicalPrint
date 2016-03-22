//
//  FirstViewController.m
//  MedicalPrint
//
//  Created by zhang fan on 3/15/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "FirstViewController.h"
#import "UserInfoRequest.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 60, 50, 45)];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
    [UserInfoRequest sendCodeWithBlock:^(NSString *code) {
        [UserInfoRequest registerWithAccount:@"fdsasadfa" password:@"123456" phone:@"13828222838" code:@"888888" withSuccess:^(User *user, BOOL status) {
            [UserInfoRequest loginWithAccount:@"fdsasadfa" passwork:@"123456" withSuccess:^(User *user, BOOL loginStatus) {
                ;
            } failure:^(NSString *msg) {
                ;
            }];
        } failure:^(NSString *error) {
        }];
        //        [expectation fulfill];
    } failure:^(NSString *msg) {
    }];

}

- (IBAction)buttonClicked:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
