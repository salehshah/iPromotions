//
//  S4MMoreInfoViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MRequestMoreInfoViewController.h"
#import "S4MAlertManager.h"
#import "S4MPromotion.h"

@interface S4MRequestMoreInfoViewController () 

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UISwitch *sendPromotionsSwitch;

@property (strong, nonatomic) MFMailComposeViewController *composeViewController;
@property (strong, nonatomic) S4MPromotion *promotion;

- (void)configureView;
- (void)sendButtonPressed:(id)sender;
- (void)cancelButtonPressed:(id)sender;
- (void)doneClicked:(id)sender;
- (NSError *)validateFields;
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

#pragma mark - Public Methods

- (void)setSelectedPromotion:(S4MPromotion *)promotion {
    self.promotion = promotion;
}

#pragma mark - Private Methods

- (void)configureView {
    self.navigationController.navigationBar.hidden = NO;
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(sendButtonPressed:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancelButtonPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)sendButtonPressed:(id)sender {
    NSError *error = [self validateFields];
    if (!error) {
        NSString *messgageBody = [self buildMessageBody];
        
        if ([MFMailComposeViewController canSendMail]) {
            _composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
            [self.composeViewController setMailComposeDelegate:self];
            [self.composeViewController setToRecipients:@[@"MJeblak@farabi.ae"]];
            [self.composeViewController setSubject:@"Request more info"];
            [self.composeViewController setMessageBody:messgageBody isHTML:NO];
            [self presentViewController:self.composeViewController animated:YES completion:nil];
        }
        else {
            [S4MAlertManagerInstance showAlertWithSender:self message:@"Mail services are not available."];
        }
    }
    else {
        //show error
        
        NSArray *actions = nil;
        if ([UIAlertController class]) {
            // use UIAlertController when available
            UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"OK", @"")
                                           style:UIAlertActionStyleCancel
                                        handler:nil];
            actions = [NSArray arrayWithObjects:okAction, nil];
            [S4MAlertManagerInstance showAlertForError:error sender:self actions:actions];
            
        } else {
            // use UIAlertView for legacy version
            actions = [NSArray arrayWithObjects:NSLocalizedString(@"OK", @""), nil];
            [S4MAlertManagerInstance showAlertForError:error sender:nil actions:actions];
        }
        
    }
    
}

- (void)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSError *)validateFields {
    //return nserror
    
    NSError *error = nil;
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    NSString *errorDomain = @"NSErrorDomainFieldValidation";
    NSInteger errorCode = 9999;
    if (!self.nameTextField.text || [self.nameTextField.text isEqualToString:@""]) {
        [userInfo setObject:@"Name field cannot be empty." forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
        return error;
    }
    if (!self.mobileTextField.text || [self.mobileTextField.text isEqualToString:@""]) {
        [userInfo setObject:@"Mobile field cannot be empty." forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
        return error;
    }
    else {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setLocale: [NSLocale systemLocale]];
        [formatter setAllowsFloats: NO];
        if (![formatter numberFromString: self.mobileTextField.text]) {
            [userInfo setObject:@"Mobile number is not in correct format." forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
            return error;
        }
    }
    if (!self.emailTextField.text || [self.emailTextField.text isEqualToString:@""]) {
        [userInfo setObject:@"Email field cannot be empty." forKey:NSLocalizedDescriptionKey];
        error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
        return error;
    }
    else {
        BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
        NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
        NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
        NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if (![emailTest evaluateWithObject:self.emailTextField.text]) {
            [userInfo setObject:@"Email is not in the correct format." forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
            return error;
        }
    }
    if (self.birthDateField.text && ![self.birthDateField.text isEqualToString:@""]) {
        NSString *birthDate = self.birthDateField.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
        NSDate *date = [dateFormatter dateFromString:birthDate];
        if (!date) {
            [userInfo setObject:@"Birth date is not in the correct format." forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:errorDomain code:errorCode userInfo:userInfo];
            return error;
        }
    }
    return error;
}

- (void)doneClicked:(id)sender {
    UIBarButtonItem *doneButton = (UIBarButtonItem *)sender;
    if (doneButton.tag == 11) { // done tapped on mobile number field
        [self.emailTextField becomeFirstResponder];
    }
    else if (doneButton.tag == 12) { // done tapped on date field
        [self dateTextField:nil];
        [self.addressField becomeFirstResponder];
    }
    
}
- (void)dateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)self.birthDateField.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MMMM dd, yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.birthDateField.text = [NSString stringWithFormat:@"%@",dateString];
}

- (void)addToolbarToTextField:(UITextField *)textField {
    
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
    textField.inputAccessoryView = keyboardDoneButtonView;
    
    if (textField == self.mobileTextField) {
        doneButton.tag = 11;
    }
    else if (textField == self.birthDateField) {
        doneButton.tag = 12;
    }
}

-(NSString *)buildMessageBody {
    NSMutableString *messageBody = [[NSMutableString alloc] init];
    [messageBody appendFormat:@"Name: %@",self.nameTextField.text];
    [messageBody appendString:@"\n"];
    [messageBody appendFormat:@"Mobile: %@",self.mobileTextField.text];
    [messageBody appendString:@"\n"];
    [messageBody appendFormat:@"Email: %@",self.emailTextField.text];
    [messageBody appendString:@"\n"];
    [messageBody appendFormat:@"Birth Date: %@",self.birthDateField.text];
    [messageBody appendString:@"\n"];
    [messageBody appendFormat:@"Address: %@",self.addressField.text];
    [messageBody appendString:@"\n"];
    [messageBody appendString:@"\n"];
    
    if (self.promotion && self.sendPromotionsSwitch.isOn) {
        [messageBody appendString:@"Promotion: \n\n"];
        [messageBody appendString:self.promotion.announcementDescription];
    }
    
    
    return messageBody;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.nameTextField) {
        [self.mobileTextField becomeFirstResponder];
        return NO;
    }
    else if (textField == self.mobileTextField) {
        [self.emailTextField becomeFirstResponder];
        return NO;
    }
    else if (textField == self.emailTextField) {
        [self.birthDateField becomeFirstResponder];
        return NO;
    }
    else if (textField == self.birthDateField) {
        [self.addressField becomeFirstResponder];
        return NO;
    }
    else {
        [textField resignFirstResponder];
        return YES;
    }
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.mobileTextField && !textField.inputAccessoryView) {
        [self addToolbarToTextField:self.mobileTextField];
    }
    else if (textField == self.birthDateField && !textField.inputView) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        [datePicker setDate:[NSDate date]];
        [datePicker setMaximumDate:[NSDate date]]; // date of birth cannot be in future
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
        [self.birthDateField setInputView:datePicker];
        [self addToolbarToTextField:self.birthDateField];
    }
    return YES;
}

#pragma mark - MFMessageComposerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self.composeViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
