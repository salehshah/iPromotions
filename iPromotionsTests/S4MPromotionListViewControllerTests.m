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

#pragma mark - View loading tests

-(void)testThatViewLoads
{
    XCTAssertNotNil(self.viewController.view, @"View not initiated properly");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.viewController.tableView, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.viewController.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.viewController conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.viewController.tableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = [self.viewController.promotions count];
    
    XCTAssertTrue([self.viewController tableView:self.viewController.tableView numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[self.viewController tableView:self.viewController.tableView numberOfRowsInSection:0], (long)expectedRows);
}

- (void)testTableViewHeightForRowAtIndexPath
{
    CGFloat expectedHeight = 44.0f;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CGFloat actualHeight = [self.viewController tableView:self.viewController.tableView heightForRowAtIndexPath:indexPath];
    XCTAssertEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}

- (void)testTableViewCellCreateCellsWithReuseIdentifier
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UITableViewCell *cell = [self.viewController tableView:self.viewController.tableView cellForRowAtIndexPath:indexPath];
    NSString *expectedReuseIdentifier = @"PromotionCell";
    XCTAssertTrue([cell.reuseIdentifier isEqualToString:expectedReuseIdentifier], @"Table does not create reusable cells");
}


@end
