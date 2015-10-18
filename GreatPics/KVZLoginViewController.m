//
//  KVZLoginViewController.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/2/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZLoginViewController.h"
#import "AFNetworking.h"
#import "KVZTokenFinder.h"

static NSString *const INSTAGRAM_AUTH_URL = @"https://api.instagram.com/oauth/authorize/?";
static NSString *const INSTAGRAM_REDIRECT_URI = @"https://yalantis.com";
static NSString *const INSTAGRAM_CLIENT_SECRET = @"5d245e1de66a4f75a4779468c03a8f8d";
static NSString *const INSTAGRAM_CLIENT_ID  = @"ffce67cce0814cb996eef468646cf08f";

@interface KVZLoginViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, copy) KVZLoginCompletionBlock completionBlock;

@end

@implementation KVZLoginViewController

#pragma mark - Main

+ (KVZLoginViewController *)loginControllerWithCompletionBlock:(KVZLoginCompletionBlock)completionBlock{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KVZLoginViewController *loginController = [sb instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    loginController.completionBlock = completionBlock;
    return loginController;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self login];
}

#pragma mark - Login

- (void)login {
    NSString *urlString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@&response_type=token", INSTAGRAM_AUTH_URL, INSTAGRAM_CLIENT_ID, INSTAGRAM_REDIRECT_URI];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    NSString *accessToken = [KVZTokenFinder accessTokenAfterCheck:urlString];
    if (accessToken.length != 0) {
        if (self.completionBlock) {
        self.completionBlock(accessToken);
        }
        return NO;
    }
    return YES;
}

@end
