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
- (void)doneClicked:(id)sender;
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
    
}

- (void)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)sendPromotionsSwitchValueChanged:(id)sender {
    
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

@end
