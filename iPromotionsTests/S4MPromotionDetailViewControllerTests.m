//
//  S4MPromotionDetailViewControllerTests.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MPromotionDetailViewController_Private.h"
#import "S4MPromotion.h"

@interface S4MPromotionDetailViewControllerTests : XCTestCase

@property (nonatomic, strong) S4MPromotionDetailViewController *viewController;

@end

@implementation S4MPromotionDetailViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"PromotionDetail"];
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

#pragma mark - Public method tests

- (void)testPromotionHTMLString {
    NSString *htmlString = @"This is a html string";
    S4MPromotion *promotion = [S4MPromotion testObject];
    [self.viewController setSelectedPromotion:promotion];
    XCTAssertEqualObjects(htmlString, self.viewController.promotion.announcementHTML, @"HTML strings not set properly");
}

#pragma mark - View loading tests

- (void)testThatViewLoads {
    XCTAssertNotNil(self.viewController.view, @"View not initiated properly");
}

-(void)testThatWebViewLoads {
    XCTAssertNotNil(self.viewController.detailWebView, @"Webview not initiated");
}

#pragma mark - UIWebView tests

- (void)testThatUIWebViewConformsToUIWebViewDelegate {
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UIWebViewDelegate)], @"View does not conform to UIWebView delegate protocol");
}




@end
