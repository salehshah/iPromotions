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

@interface S4MPromotionDetailViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSString *htmlString;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

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

- (void)setPromotionHTMLString:(NSString *)htmlString {
    self.htmlString = htmlString;
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
    [self.detailWebView loadHTMLString:self.htmlString baseURL:nil];
}
- (void)openActionSheet {
    
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
        // use UIAlertView for legacy version
        
        actions = [NSArray arrayWithObjects:NSLocalizedString(@"OK", @""), nil];
        [S4MAlertManagerInstance showAlertForError:error sender:nil actions:actions];
    }
    
}

@end
