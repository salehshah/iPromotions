//
//  S4MUtilsTests.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MUtils.h"

@interface S4MUtilsTests : XCTestCase

@end

@implementation S4MUtilsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testErrorMessageForErrorCode {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSString *errorMessage = [S4MUtils errorMessageForErrorCode:0];
    XCTAssertNotNil(errorMessage,@"Error message is nil");
    
    errorMessage = [S4MUtils errorMessageForErrorCode:-1009];
    XCTAssertNotNil(errorMessage,@"Error message is nil");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
