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
    
    NSError *error = nil;
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    NSString *errorDomain = @"NSErrorDomainTest";
    NSInteger errorCode = 0;
    [userInfo setObject:@"This is a test error" forKey:NSLocalizedDescriptionKey];
    error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
    
    NSString *errorMessage = [S4MUtils errorMessageForError:error];
    XCTAssertNotNil(errorMessage,@"Error message is nil");
    
    errorCode = 9999;
    [userInfo setObject:@"This is a test error" forKey:NSLocalizedDescriptionKey];
    error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
    
    errorMessage = [S4MUtils errorMessageForError:error];
    XCTAssertNotNil(errorMessage,@"Error message is nil");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
