//
//  S4MRequestMoreInfoTests.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MRequestMoreInfoViewController_Private.h"


@interface S4MRequestMoreInfoViewControllerTests : XCTestCase

@property (nonatomic, strong) S4MRequestMoreInfoViewController *viewController;

@end

@implementation S4MRequestMoreInfoViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"RequestMoreInfo"];
    [self.viewController view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.viewController = nil;
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - View loading tests

- (void)testThatViewLoads {
    XCTAssertNotNil(self.viewController.view, @"View not initiated properly");
}

- (void)testIfTextFieldsHaveDelegate {
    
    XCTAssertNotNil(self.viewController.nameTextField.delegate, @"Field does not conform to UITextField delegate");
    XCTAssertNotNil(self.viewController.mobileTextField.delegate, @"Field does not conform to UITextField delegate");
    XCTAssertNotNil(self.viewController.emailTextField.delegate, @"Field does not conform to UITextField delegate");
    XCTAssertNotNil(self.viewController.birthDateField.delegate, @"Field does not conform to UITextField delegate");
    XCTAssertNotNil(self.viewController.addressField.delegate, @"Field does not conform to UITextField delegate");
    
}

#pragma mark - View set up tests

- (void)testConfigureView {
    [self.viewController configureView];
    XCTAssertNotNil(self.viewController.navigationItem.rightBarButtonItem,@"Right bar item not added properly");
    XCTAssertNotNil(self.viewController.navigationItem.leftBarButtonItem,@"Left bar item not added properly");
    
    UIBarButtonItem *barItem = self.viewController.navigationItem.rightBarButtonItem;
    SEL action = barItem.action;
    NSString *actionName = NSStringFromSelector(action);
    if (![actionName isEqualToString:@"sendButtonPressed"]) {
        XCTAssertFalse(@"Right bar button target not set properly");
    }
    
    barItem = self.viewController.navigationItem.leftBarButtonItem;
    action = barItem.action;
    actionName = NSStringFromSelector(action);
    if (![actionName isEqualToString:@"cancelButtonPressed"]) {
        XCTAssertFalse(@"Left bar button target not set properly");
    }
}

- (void)testValidateFields {
    
}

@end
