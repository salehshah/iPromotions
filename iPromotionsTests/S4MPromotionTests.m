//
//  iPromotionsModalTests.m
//  iPromotions
//
//  Created by Saleh Shah on 14/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MPromotion.h"
#import "S4MConstants.h"

@interface S4MPromotionTests : XCTestCase

@end

@implementation S4MPromotionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPopulateObjectWithDictionary {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *ID = @"1344";
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    [dataDict setObject:ID forKey:@"ID"];
    
    S4MPromotion *promption = [[S4MPromotion alloc] init];
    [promption populateObjectWithDictionary:dataDict];
    
    if (![promption.ID isEqualToString:ID]) {
        
        XCTAssertFalse(@"Properties have not been set properly");
        
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
