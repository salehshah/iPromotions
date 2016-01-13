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


-(void)loadData {
    
//    NSString *urlString = [NSString stringWithFormat:BASE_URL,CLIENT_ID,CLIENT_SECRET,[CNUtil formattedCoordinatesStringWithCoordinates:coordinates]];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [self.listController startActivityIndicator];
//    self.viewSwitchButton.enabled = NO;
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        [self.listController stopActivityIndicator];
//        self.viewSwitchButton.enabled = YES;
//        
//        NSDictionary *metaDictionary = [responseObject objectForKey:META_STRING];
//        
//        NSInteger code = [[metaDictionary objectForKey:CODE_STRING] integerValue];
//        if (code != 200) {
//            [self showDataError:nil];
//        }
//        else {
//            NSArray *venues = [[responseObject objectForKey:RESPONSE_STRING] objectForKey:VENUES_STRING];
//            _places = [CNUtil sortPlacesAccordingToDistanceWithPlaces:[CNPlace populatePlacesWithDictionary:venues]];
//            NSLog(@"places count: %lu",(unsigned long)[self.places count]);
//            
//            [self.listController reloadTableViewData:self.places];
//            [self.mapController configureMapToAddPlaces:self.places];
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [self.listController stopActivityIndicator];
//        
//        [self showDataError:error];
//    }];
//    
//    [operation start];

}

@end
