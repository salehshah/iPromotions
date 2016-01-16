//
//  S4MAlertManagerTests.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MAlertManager.h"

@interface S4MAlertManagerTests : XCTestCase

@end

@implementation S4MAlertManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShowAlertForError {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [S4MAlertManagerInstance showAlertForError:nil sender:nil actions:nil];
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIView *view = [[window subviews] objectAtIndex:0];
    
    if ([view isKindOfClass:[UIAlertView class]] || [view isKindOfClass:[UIAlertController class]]) {
        XCTAssert(@"Error is visible on screen, which should not be visible because error is null");
    }
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: NSLocalizedString(@"This is test error", nil) };
    
    NSError *error = [NSError errorWithDomain:@"NSErrorDomainTest"
                                         code:-57
                                     userInfo:userInfo];
    [S4MAlertManagerInstance showAlertForError:error sender:nil actions:nil];
    
    view = [[window subviews] objectAtIndex:0];
    
    if (![view isKindOfClass:[UIAlertView class]] && ![view isKindOfClass:[UIAlertController class]]) {
        XCTAssert(@"Error is not visible on screen");
    }
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
