//
//  S4MMoreInfoViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MRequestMoreInfoViewController.h"

@interface S4MRequestMoreInfoViewController () 

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UISwitch *sendPromotionsSwitch;

- (void)configureView;
- (void)sendButtonPressed:(id)sender;
- (void)cancelButtonPressed:(id)sender;
- (IBAction)sendPromotionsSwitchValueChanged:(id)sender;

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

- (void)sendButtonPressed:(id)sender {
    
}

- (void)cancelButtonPressed:(id)sender {
    
}

- (IBAction)sendPromotionsSwitchValueChanged:(id)sender {
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

@end
