//
//  S4MPromotionListViewControllerTests.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "S4MPromotionListViewController_Private.h"
#import "S4MPromotion.h"

@interface S4MPromotionListViewControllerTests : XCTestCase

@property (nonatomic, strong) S4MPromotionListViewController *viewController;

@end

@implementation S4MPromotionListViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"PromotionList"];
    self.viewController.promotions = [NSArray arrayWithObjects:[S4MPromotion testObject],[S4MPromotion testObject],[S4MPromotion testObject], nil];
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

#pragma mark - Error Test

-(void)testShowError {
    [self.viewController showDataLoadErrorWithError:nil];
    
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
    [self.viewController showDataLoadErrorWithError:error];
    
    view = [[window subviews] objectAtIndex:0];
    
    if (![view isKindOfClass:[UIAlertView class]] && ![view isKindOfClass:[UIAlertController class]]) {
        XCTAssert(@"Error is not visible on screen");
    }
}

#pragma mark - View loading tests

-(void)testThatViewLoads
{
    XCTAssertNotNil(self.viewController.view, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = self.viewController.view.subviews;
    XCTAssertTrue([subviews containsObject:self.viewController.promotionsTableView], @"View does not have a table subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.viewController.promotionsTableView, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.viewController.promotionsTableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.viewController.promotionsTableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = [self.viewController.promotions count];
    
    XCTAssertTrue([self.viewController tableView:self.viewController.promotionsTableView numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[self.viewController tableView:self.viewController.promotionsTableView numberOfRowsInSection:0], (long)expectedRows);
}

- (void)testTableViewHeightForRowAtIndexPath
{
    CGFloat expectedHeight = 44.0f;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CGFloat actualHeight = [self.viewController tableView:self.viewController.promotionsTableView heightForRowAtIndexPath:indexPath];
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.viewController tableView:self.viewController.promotionsTableView cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = @"PromotionCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}


@end
