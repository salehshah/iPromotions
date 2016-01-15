//
//  ViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 13/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotionListViewController.h"
#import "S4MLoadingManager.h"

@interface S4MPromotionListViewController ()

@end

@implementation S4MPromotionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[S4MLoadingManager sharedManager] showLoadingIndidcatorView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)showDataLoadErrorWithMessage:(NSString *)errorMessage {
    
    if ([UIAlertController class]) {
        // use UIAlertController
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        
        //[self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        // use UIAlertView
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
        [alertView show];
        
    }
    
    
}

@end
