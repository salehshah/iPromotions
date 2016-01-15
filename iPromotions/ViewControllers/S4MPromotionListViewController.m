//
//  ViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 13/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotionListViewController.h"
#import "S4MLoadingManager.h"
#import "S4MDataManager.h"
#import "S4MPromotion.h"
#import "S4MConstants.h"


@interface S4MPromotionListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *promotions;
@property (weak, nonatomic) IBOutlet UITableView *promotionsTableView;

@end

@implementation S4MPromotionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Promotions";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.promotions) {
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

-(void)loadData {
    [[S4MLoadingManager sharedManager] showLoadingIndidcatorView];
    
    [[S4MDataManager sharedManager] loadData:^(id responseObject) {
       
        NSNumber *result = [responseObject objectForKey:S4M_RESULT_KEY];
        if ([result boolValue]) {
            _promotions = [responseObject objectForKey:S4M_RESPONSE_OBJECT_KEY];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.promotionsTableView reloadData];
            });
        }
        else {
            NSError *error = [responseObject objectForKey:S4M_ERROR_KEY];
            [self showDataLoadErrorWithMessage:error];
        }
        [[S4MLoadingManager sharedManager] hideLoadingIndidcatorView];
    }];
    
}

- (void)showDataLoadErrorWithMessage:(NSError *)error {
    
    if ([UIAlertController class]) {
        // use UIAlertController
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[error description] preferredStyle:UIAlertControllerStyleAlert];
        
        //[self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        // use UIAlertView
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:[error description] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
        [alertView show];
        
    }
    
    
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.promotions count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PromotionCell" forIndexPath:indexPath];
    
    S4MPromotion *promotion = [self.promotions objectAtIndex:indexPath.row];
    cell.textLabel.text = promotion.announcementTitle;
    cell.detailTextLabel.text = promotion.announcementDate;
    
    return cell;

}

@end
