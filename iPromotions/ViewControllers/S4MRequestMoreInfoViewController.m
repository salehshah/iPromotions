//
//  S4MMoreInfoViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MRequestMoreInfoViewController.h"

@interface S4MRequestMoreInfoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *sendPromotionsSwitch;

- (void)configureView;

- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end

@implementation S4MRequestMoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Promotion Detail";
    [self configureView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)configureView {
    
}

- (IBAction)sendButtonPressed:(id)sender {
    
}

@end
