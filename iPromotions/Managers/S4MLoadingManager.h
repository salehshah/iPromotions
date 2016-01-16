//
//  S4MLoadingManager.h
//  iPromotions
//
//  Created by Saleh Shah on 15/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define S4MLoadingManagerInstance [S4MLoadingManager sharedManager]

@interface S4MLoadingManager : NSObject

+ (S4MLoadingManager *)sharedManager;
- (void)showLoadingIndidcatorView;
- (void)hideLoadingIndidcatorView;

@end
