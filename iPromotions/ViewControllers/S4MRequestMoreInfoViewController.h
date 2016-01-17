//
//  S4MMoreInfoViewController.h
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class S4MPromotion;
@interface S4MRequestMoreInfoViewController : UIViewController <UITextFieldDelegate,MFMailComposeViewControllerDelegate>

- (void)setSelectedPromotion:(S4MPromotion *)promotion;

@end
