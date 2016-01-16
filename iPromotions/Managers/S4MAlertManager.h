//
//  S4MAlertManager.h
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define S4MAlertManagerInstance [S4MAlertManager sharedManager]

@interface S4MAlertManager : NSObject

+ (S4MAlertManager *)sharedManager;

- (void)showAlertForError:(NSError *)error sender:(UIViewController *)sender actions:(NSArray *)actions;

@end
