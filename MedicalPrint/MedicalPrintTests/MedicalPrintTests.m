//
//  MedicalPrintTests.m
//  MedicalPrintTests
//
//  Created by zhang fan on 3/15/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserInfoRequest.h"

@interface MedicalPrintTests : XCTestCase

@end

@implementation MedicalPrintTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation  = [self expectationWithDescription: @"quit"];

    [UserInfoRequest registerWithAccount:@"fdsa" password:@"123456" phone:@"123456789" code:@"888888" withSuccess:^(User *user, BOOL status) {
        NSAssert(true, @"success");
        [expectation fulfill];
    } failure:^(NSString *error) {
        NSAssert(false, @"failed");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout: 10 handler:^(NSError * _Nullable error) {
        NSAssert(error == nil, @"registerWithAccount failed");
    }];
}

- (void)testSendCode {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation  = [self expectationWithDescription: @"testSendCode"];
    
    [UserInfoRequest sendCodeWithBlock:^(NSString *code) {
        NSAssert(true, @"success");
        [UserInfoRequest registerWithAccount:@"fdsasadf" password:@"123456" phone:@"13828222838" code:@"888888" withSuccess:^(User *user, BOOL status) {
            NSAssert(true, @"success");
            [expectation fulfill];
        } failure:^(NSString *error) {
            NSAssert(false, @"failed");
            [expectation fulfill];
        }];
//        [expectation fulfill];
    } failure:^(NSString *msg) {
        NSAssert(false, @"failed");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout: 100 handler:^(NSError * _Nullable error) {
        NSAssert(error == nil, @"testSendCode failed");
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
