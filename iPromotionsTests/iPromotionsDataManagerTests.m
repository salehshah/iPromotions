//
//  iPromotionsTests.m
//  iPromotionsTests
//
//  Created by Saleh Shah on 13/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MDataManager.h"
#import "S4MConstants.h"

@interface iPromotionsDataManagerTests : XCTestCase {
    S4MDataManager *dataManager;
}

@end

@implementation iPromotionsDataManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    dataManager = S4MDataManagerInstance;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    dataManager = nil;
}

- (void)testDataManager {
    XCTAssertNotNil(dataManager, @"Data manager is nil");
}

- (void)testLoadData {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Load data HTTP request"];
    [dataManager loadData:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:S4M_REQUEST_TIME_OUT_INTERVAL handler:nil];
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
