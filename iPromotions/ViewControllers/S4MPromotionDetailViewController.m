//
//  S4MDetailViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotionDetailViewController.h"
#import "S4MLoadingManager.h"
#import "S4MAlertManager.h"
#import "S4MPromotion.h"
#import "S4MRequestMoreInfoViewController.h"

@interface S4MPromotionDetailViewController () <UIWebViewDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
@property (nonatomic, strong) S4MPromotion *promotion;

@end

@implementation S4MPromotionDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Promotion Detail";
    [self configureView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Methods

- (void)setSelectedPromotion:(S4MPromotion *)promotion {
    self.promotion = promotion;
}

#pragma mark - Private Methods

- (void)configureView {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                               target:self
                                                                               action:@selector(openActionSheet)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)loadWebView {
    [S4MLoadingManagerInstance showLoadingIndidcatorView];
    [self.detailWebView loadHTMLString:self.promotion.announcementHTML baseURL:nil];
}
- (void)openActionSheet {
    NSArray *actions = nil;
    if ([UIAlertController class]) {
        // use UIAlertController when available
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"")
                                       style:UIAlertActionStyleCancel
                                       handler:nil];
        
        UIAlertAction *moreInfoAction = [UIAlertAction
                                      actionWithTitle:NSLocalizedString(@"Request More Info", @"")
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction *action)
                                      {
                                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                          S4MRequestMoreInfoViewController *requestMoreInfoViewController = [storyboard instantiateViewControllerWithIdentifier:@"RequestMoreInfo"];
                                          UINavigationController *navigationController =
                                          [[UINavigationController alloc] initWithRootViewController:requestMoreInfoViewController];
                                          [self presentViewController:navigationController animated:YES completion:nil];
                                          
                                      }];
        UIAlertAction *shareAction = [UIAlertAction
                                         actionWithTitle:NSLocalizedString(@"Share", @"")
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction *action)
                                         {
                                             [self openSharingController];
                                             
                                         }];
        
        actions = [NSArray arrayWithObjects:cancelAction,moreInfoAction,shareAction, nil];
        
    } else {
        // use UIAlertView for legacy version
        
        actions = [NSArray arrayWithObjects:NSLocalizedString(@"Cancel", @""),NSLocalizedString(@"Request More Info", @""),NSLocalizedString(@"Share", @""), nil];
    }
    
    [S4MAlertManagerInstance showActionSheetWithSender:self actions:actions];
}

- (void)openSharingController {
    
    NSArray* sharedObjects=[NSArray arrayWithObjects:self.promotion.announcementDescription, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [S4MLoadingManagerInstance hideLoadingIndidcatorView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [S4MLoadingManagerInstance hideLoadingIndidcatorView];

    NSArray *actions = nil;
    if ([UIAlertController class]) {
        // use UIAlertController when available
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"OK", @"")
                                   style:UIAlertActionStyleDefault
                                   handler:nil];
        actions = [NSArray arrayWithObjects:okAction, nil];
        [S4MAlertManagerInstance showAlertForError:error sender:self actions:actions];
        
    } else {
        // use UIAlertView for legacy versions
        actions = [NSArray arrayWithObjects:NSLocalizedString(@"OK", @""), nil];
        [S4MAlertManagerInstance showAlertForError:error sender:nil actions:actions];
    }
    
}

@end
