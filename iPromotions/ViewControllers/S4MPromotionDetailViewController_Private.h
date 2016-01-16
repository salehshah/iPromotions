//
//  S4MPromotionDetailViewController_Private.h
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotionDetailViewController.h"
@class S4MPromotion;
@interface S4MPromotionDetailViewController ()

@property (nonatomic, strong) S4MPromotion *promotion;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@end
