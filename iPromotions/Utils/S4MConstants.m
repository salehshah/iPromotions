//
//  S4MConstants.m
//  iPromotions
//
//  Created by Saleh Shah on 13/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MConstants.h"

#pragma mark - API URL
NSString *const S4M_DATA_URL = @"http://www.solutions4mobility.com/AABToyota/ipdp/ipdpb.ashx?CFG=OPTIMAL&p=Common.Announcements&Handler=News&MODULE_ID=501&TemplateName=News.htm&APPLICATION_NAME=TOYOTA&F=J";

#pragma mark - API Keys

NSString *const S4M_PROMOTION_ID = @"ID";
NSString *const S4M_PROMOTION_NATIVE_DATE = @"NATIVE_DATE";
NSString *const S4M_PROMOTION_ANNOUNCEMENT_DATE = @"ANNOUNCEMENT_DATE";
NSString *const S4M_PROMOTION_EXPIRY = @"EXPIRY";
NSString *const S4M_PROMOTION_ANNOUNCEMENT_DESCRIPTION = @"ANNOUNCEMENT_DESCRIPTION";
NSString *const S4M_PROMOTION_ANNOUNCEMENT_TITLE = @"ANNOUNCEMENT_TITLE";
NSString *const S4M_PROMOTION_ANNOUNCEMENT_IMAGE = @"ANNOUNCEMENT_IMAGE";
NSString *const S4M_PROMOTION_ANNOUNCEMENT_IMAGE_THUMBNAIL = @"ANNOUNCEMENT_IMAGE_THUMBNAIL";
NSString *const S4M_PROMOTION_ANNOUNCEMENT_HTML = @"ANNOUNCEMENT_HTML";

#pragma mark - Common Keys

NSString *const S4M_RESULT_KEY = @"Result";
NSString *const S4M_ERROR_KEY = @"Error";
NSString *const S4M_RESPONSE_KEY = @"Response";
NSString *const S4M_RESPONSE_OBJECT_KEY = @"ResponseObject";

#pragma mark - Commons

NSInteger const S4M_REQUEST_TIME_OUT_INTERVAL = 30;
