//
//  S4MPromotion.m
//  iPromotions
//
//  Created by Saleh Shah on 14/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotion.h"
#import "S4MConstants.h"

@interface S4MPromotion ()

@end

@implementation S4MPromotion

#pragma mark - Public Methods
- (void)populateObjectWithDictionary:(NSDictionary *)dictionary {
    self.ID = [dictionary objectForKey:S4M_PROMOTION_ID];
    self.nativeDate = [dictionary objectForKey:S4M_PROMOTION_NATIVE_DATE];
    self.announcementDate = [dictionary objectForKey:S4M_PROMOTION_ANNOUNCEMENT_DATE];
    self.expiry = [dictionary objectForKey:S4M_PROMOTION_EXPIRY];
    self.announcementDescription = [dictionary objectForKey:S4M_PROMOTION_ANNOUNCEMENT_DESCRIPTION];
    self.announcementTitle = [dictionary objectForKey:S4M_PROMOTION_ANNOUNCEMENT_TITLE];
    self.announcementImage = [dictionary objectForKey:S4M_PROMOTION_ANNOUNCEMENT_IMAGE];
    self.announcementImageThumbnail= [dictionary objectForKey:S4M_PROMOTION_ANNOUNCEMENT_IMAGE_THUMBNAIL];
    self.announcementHTML = [dictionary objectForKey:S4M_PROMOTION_ANNOUNCEMENT_HTML];
}

+ (S4MPromotion *)testObject {
    S4MPromotion *promotion = [[S4MPromotion alloc] init];
    promotion.ID = @"1111";
    promotion.announcementTitle = @"Test Promotion";
    promotion.announcementDate = @"Jan 1, 1970";
    promotion.announcementHTML = @"This is a html string";
    return promotion;
}
@end
