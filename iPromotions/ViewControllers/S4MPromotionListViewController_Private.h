//
//  S4MPromotionListViewController_Private.h
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotionListViewController.h"

@interface S4MPromotionListViewController ()

@property (nonatomic, strong) NSArray *promotions;

- (void)loadData;
- (void)showDataLoadErrorWithError:(NSError *)error;

@end
