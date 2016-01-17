//
//  S4MUtils.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MUtils.h"

@implementation S4MUtils

+ (NSString *)errorMessageForError:(NSError *)error {
    NSString *errorMessage = nil;
    NSInteger code = error.code;
    switch (code) {
        case -1009:
            errorMessage = NSLocalizedString(@"Your connection appears to be offline. Try again after connecting to an internet connection.", @"");
            break;
        case -1004:
            errorMessage = NSLocalizedString(@"Could not connect to the server, please try again.", @"");
            break;
        case -1003:
            errorMessage = NSLocalizedString(@"Server not responding, please try again.", @"");
            break;
        case 9999:
            errorMessage = NSLocalizedString([error localizedDescription], @"");
            break;
            
        default:
            errorMessage = NSLocalizedString(@"Something went wrong, please try again.", @"");
            break;
    }
    return errorMessage;
}

@end
