//
//  S4MRequestMoreInfoViewController_Private.h
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
- (NSError *)validateFields;

@end
