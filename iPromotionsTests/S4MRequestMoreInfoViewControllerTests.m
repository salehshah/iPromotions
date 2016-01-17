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
    if (![actionName isEqualToString:@"sendButtonPressed:"]) {
        XCTAssertFalse(@"Right bar button target not set properly");
    }
    
    barItem = self.viewController.navigationItem.leftBarButtonItem;
    action = barItem.action;
    actionName = NSStringFromSelector(action);
    if (![actionName isEqualToString:@"cancelButtonPressed:"]) {
        XCTAssertFalse(@"Left bar button target not set properly");
    }
}

#pragma mark - UITextFieldDelegate

- (void)testIfTextFieldShouldReturnMethod {
    [self.viewController textFieldShouldReturn:self.viewController.nameTextField];
    XCTAssertFalse(self.viewController.mobileTextField.isFirstResponder,@"Fields return button not working properly");
    [self.viewController textFieldShouldReturn:self.viewController.mobileTextField];
    XCTAssertFalse(self.viewController.emailTextField.isFirstResponder,@"Fields return button not working properly");
    [self.viewController textFieldShouldReturn:self.viewController.emailTextField];
    XCTAssertFalse(self.viewController.birthDateField.isFirstResponder,@"Fields return button not working properly");
    [self.viewController textFieldShouldReturn:self.viewController.birthDateField];
    XCTAssertFalse(self.viewController.addressField.isFirstResponder,@"Fields return button not working properly");
    [self.viewController textFieldShouldReturn:self.viewController.addressField];
    XCTAssertFalse(self.viewController.addressField.isFirstResponder,@"Fields return button not working properly");
}

#pragma mark - Validation

- (void)testValidateFields {
    self.viewController.nameTextField.text = nil;
    self.viewController.mobileTextField.text = @"this is not a phone number";
    self.viewController.emailTextField.text = @"this is not a valid email";
    self.viewController.birthDateField.text = @"this is not valid date";
    self.viewController.addressField.text = nil;
    XCTAssertTrue([self.viewController validateFields],@"Fields are not validated properly");
    
    self.viewController.nameTextField.text = @"S. Shah";
    self.viewController.mobileTextField.text = @"76999911";
    self.viewController.emailTextField.text = @"sshah@randommail.com";
    self.viewController.birthDateField.text = @"June 3, 1987";
    self.viewController.addressField.text = nil;
    XCTAssertFalse([self.viewController validateFields],@"Fields are not validated properly");
    
}

#pragma mark - Test actions

- (void)testSendButtonPressed {
    self.viewController.nameTextField.text = nil;
    self.viewController.mobileTextField.text = @"this is not a phone number";
    self.viewController.emailTextField.text = @"this is not a valid email";
    self.viewController.birthDateField.text = @"this is not valid date";
    self.viewController.addressField.text = nil;
    [self.viewController sendButtonPressed:nil];
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIView *view = [[window subviews] objectAtIndex:0];
    
    if ([view isKindOfClass:[UIAlertView class]] || [view isKindOfClass:[UIAlertController class]]) {
        XCTAssert(@"Alert is visible on screen, which should not be visible because fields are not valid.");
    }
}

@end
