//
//  S4MDataManager.m
//  iPromotions
//
//  Created by Saleh Shah on 13/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MDataManager.h"
#import "AFNetworking.h"
#import "S4MConstants.h"

@implementation S4MDataManager

+ (S4MDataManager *) sharedManager {
    static S4MDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

#pragma mark - Public Methods

- (void)loadData:(void (^)(id responseObject))block {
    
    NSString *urlString = S4M_DATA_URL;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = S4M_REQUEST_TIME_OUT_INTERVAL;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSMutableDictionary *responseDict = [[NSMutableDictionary alloc] init];
        if (error) {
            [responseDict setObject:[NSNumber numberWithBool:NO] forKey:S4M_RESULT_KEY];
            [responseDict setObject:error forKey:S4M_ERROR_KEY];
            
        } else {
            [responseDict setObject:[NSNumber numberWithBool:YES] forKey:S4M_RESULT_KEY];
            [responseDict setObject:response forKey:S4M_RESPONSE_KEY];
            [responseDict setObject:responseObject forKey:S4M_RESPONSE_OBJECT_KEY];
        }
        block(responseDict);
    }];
    [dataTask resume];

}

#pragma mark Private Methods

- (void)showDataLoadErrorWithMessage:(NSString *)errorMessage {
    
    if ([UIAlertController class]) {
        // use UIAlertController
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        
        //[self presentViewController:alertController animated:YES completion:nil];

    } else {
        // use UIAlertView
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
        [alertView show];
        
    }
    
    
}

@end
