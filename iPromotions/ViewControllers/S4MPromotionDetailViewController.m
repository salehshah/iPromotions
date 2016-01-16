//
//  S4MDetailViewController.m
//  iPromotions
//
//  Created by Saleh Shah on 16/01/2016.
//  Copyright © 2016 Saleh Shah. All rights reserved.
//

#import "S4MPromotionDetailViewController.h"
#import "S4MLoadingManager.h"

@interface S4MPromotionDetailViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSString *htmlString;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@end

@implementation S4MPromotionDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Promotion Detail";
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

- (void)loadWebView {
    [self.detailWebView loadHTMLString:self.htmlString baseURL:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [S4MLoadingManagerInstance showLoadingIndidcatorView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [S4MLoadingManagerInstance hideLoadingIndidcatorView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"webview error: %@",[error description]);
    [S4MLoadingManagerInstance hideLoadingIndidcatorView];
}

@end
