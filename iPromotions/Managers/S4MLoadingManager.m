//
//  S4MLoadingManager.m
//  iPromotions
//
//  Created by Saleh Shah on 15/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MLoadingManager.h"

@interface S4MLoadingManager ()

@property (nonatomic, strong) UIView *loadingContainerView;
@property (nonatomic, strong) UILabel *loadingLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)setUpView;
- (void)showLoadingIndidcatorView;
- (void)hideLoadingIndidcatorView;

@end

@implementation S4MLoadingManager

#pragma mark - Public Methods

+ (S4MLoadingManager *)sharedManager {
    static S4MLoadingManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        [sharedMyManager setUpView];
    });
    return sharedMyManager;
}

- (void)showLoadingIndidcatorView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator startAnimating];
        self.loadingContainerView.hidden = NO;
    });
   
}

- (void)hideLoadingIndidcatorView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        self.loadingContainerView.hidden = YES;
    });
    
}

#pragma mark - Private Methods

- (void)setUpView {
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    float width = screenSize.width;
    float height = screenSize.height;
    
    float containerHeight = width * 0.30f;
    float containerWidth = height * 0.25f;
    
    _loadingContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerWidth, containerHeight)];
    self.loadingContainerView.backgroundColor = [UIColor blackColor];
    self.loadingContainerView.center = CGPointMake(width/2.0f, height/2.0f);
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    [[[window subviews] objectAtIndex:0] addSubview:self.loadingContainerView];
    self.loadingContainerView.layer.cornerRadius = 8.0f;
    self.loadingContainerView.layer.masksToBounds = YES;
    [self.loadingContainerView layoutIfNeeded];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.frame = CGRectMake(0, 0, 30.0f, 30.0f);
    self.activityIndicator.center = CGPointMake(containerWidth/2.0f, containerHeight/2.0f);
    [self.loadingContainerView addSubview:self.activityIndicator];
    
    _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, containerHeight - 30.0f, containerWidth - 10.0f, 21.0f)];
    self.loadingLabel.textColor = [UIColor whiteColor];
    self.loadingLabel.text = @"Loading..";
    self.loadingLabel.font = [UIFont systemFontOfSize:15.0f];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.numberOfLines = 1;
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    [self.loadingContainerView addSubview:self.loadingLabel];
    
    [self hideLoadingIndidcatorView];
}


@end
