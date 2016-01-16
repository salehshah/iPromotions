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
#import "UIImageView+AFNetworking.h"


@interface S4MPromotionListViewController ()

@property (nonatomic, strong) NSArray *promotions;
@property (weak, nonatomic) IBOutlet UITableView *promotionsTableView;

- (void)loadData;
- (void)showDataLoadErrorWithError:(NSError *)error;

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

- (void)loadData {
    [[S4MLoadingManager sharedManager] showLoadingIndidcatorView];
    
    [S4MDataManagerInstance loadData:^(id responseObject) {
       
        NSNumber *result = [responseObject objectForKey:S4M_RESULT_KEY];
        if ([result boolValue]) {
            self.promotions = [responseObject objectForKey:S4M_RESPONSE_OBJECT_KEY];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.promotionsTableView reloadData];
            });
        }
        else {
            NSError *error = [responseObject objectForKey:S4M_ERROR_KEY];
            [self showDataLoadErrorWithError:error];
        }
        [[S4MLoadingManager sharedManager] hideLoadingIndidcatorView];
    }];
    
}

- (void)showDataLoadErrorWithError:(NSError *)error {
    
    NSString *errorMessage = nil;
    if (error.code == -1009) {
        errorMessage = NSLocalizedString(@"Your connection appears to be offline. Try again after connecting to an internet connection.", @"");
    }
    else {
        errorMessage = NSLocalizedString(@"Something went wrong, please try again.", @"");
    }
    
    if ([UIAlertController class]) {
        // use UIAlertController
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:errorMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        UIAlertAction *retryAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Retry", @"")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Retry action");
                                       [self loadData];
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:retryAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    } else {
        // use UIAlertView
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                  otherButtonTitles:NSLocalizedString(@"Retry", @""), nil];
        [alertView show];
        
    }
    
    
}

#pragma mark - UIAlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"Cancel action");
    }
    else {
        NSLog(@"Retry action");
        [self loadData];
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
    __weak UITableViewCell *weakCell = cell;
    if (promotion.announcementImageThumbnail) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:promotion.announcementImageThumbnail]];
        
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            weakCell.imageView.image = image;
            [weakCell setNeedsLayout];
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    
    return cell;
}

@end
