//
//  S4MAlertManager.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MAlertManager.h"
#import "S4MUtils.h"

@implementation S4MAlertManager

+ (S4MAlertManager *)sharedManager {
    static S4MAlertManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark - Public Methods

- (void)showAlertForError:(NSError *)error sender:(UIViewController *)sender actions:(NSArray *)actions {
    
    NSString *errorMessage = [S4MUtils errorMessageForErrorCode:error.code];
    
    if ([UIAlertController class]) {
        // use UIAlertController where available
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:errorMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        
        for (UIAlertAction *action in actions) {
            [alertController addAction:action];
        }
        
        [sender presentViewController:alertController animated:YES completion:nil];
        
        
    } else {
        // use UIAlertView for legacy version
        NSString *cancelButtonTitle = nil;
        if (actions) {
            cancelButtonTitle = [actions objectAtIndex:0];
        }
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:errorMessage
                                                           delegate:sender
                                                  cancelButtonTitle:cancelButtonTitle
                                                  otherButtonTitles:nil];
        if (actions) {
            for (int i = 1; i < [actions count]; i++) {
                NSString *buttonTitle = [actions objectAtIndex:i];
                [alertView addButtonWithTitle:buttonTitle];
            }
        }
        [alertView show];
    }
}

- (void)showActionSheetWithSender:(UIViewController *)sender actions:(NSArray *)actions {
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        for (UIAlertAction *action in actions) {
            [alertController addAction:action];
        }
        
        [sender presentViewController:alertController animated:YES completion:nil];
    }
    else {
        NSString *cancelButtonTitle = nil;
        if (actions) {
            cancelButtonTitle = [actions objectAtIndex:0];
        }
        id iSender = sender; // just to get rid of the warning.
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:iSender
                                                        cancelButtonTitle:cancelButtonTitle
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];
        if (actions) {
            for (int i = 1; i < [actions count]; i++) {
                NSString *buttonTitle = [actions objectAtIndex:i];
                [actionSheet addButtonWithTitle:buttonTitle];
            }
        }
        
        [actionSheet showInView:sender.view];
    }
}

@end
