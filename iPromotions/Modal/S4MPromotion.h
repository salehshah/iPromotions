//
//  S4MPromotion.h
//  iPromotions
//
//  Created by Saleh Shah on 14/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface S4MPromotion : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *nativeDate;
@property (nonatomic, strong) NSString *announcementDate;
@property (nonatomic, strong) NSString *expiry;
@property (nonatomic, strong) NSString *announcementDescription;
@property (nonatomic, strong) NSString *announcementTitle;
@property (nonatomic, strong) NSString *announcementImage;
@property (nonatomic, strong) NSString *announcementImageThumbnail;
@property (nonatomic, strong) NSString *announcementHTML;

- (void)populateObjectWithDictionary:(NSDictionary *)dictionary;

+ (S4MPromotion *)testObject; // this method returns a dummy object which is used for unit testing
@end
