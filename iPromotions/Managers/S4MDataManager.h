//
//  S4MDataManager.h
//  iPromotions
//
//  Created by Saleh Shah on 13/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

#define S4MDataManagerInstance [S4MDataManager sharedManager];

@interface S4MDataManager : NSObject

+ (S4MDataManager *)sharedManager;

@end
