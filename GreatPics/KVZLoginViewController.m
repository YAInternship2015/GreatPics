//
//  KVZLoginViewController.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/2/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZLoginViewController.h"
#import "KVZCollectionViewController.h"
#import "AFNetworking.h"

static NSString *const INSTAGRAM_AUTH_URL = @"https://api.instagram.com/oauth/authorize/?";
static NSString *const INSTAGRAM_REDIRECT_URI = @"https://yalantis.com";
static NSString *const INSTAGRAM_CLIENT_SECRET = @"5d245e1de66a4f75a4779468c03a8f8d";
static NSString *const INSTAGRAM_CLIENT_ID  = @"ffce67cce0814cb996eef468646cf08f";

@interface KVZLoginViewController ()

@property (nonatomic, strong) KVZCollectionViewController *collectionController;

@end


@implementation KVZLoginViewController

#pragma mark Main

-(void) viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KVZCollectionViewController *collectionController = (KVZCollectionViewController *)[sb instantiateViewControllerWithIdentifier:@"collectionViewController"];
    self.collectionController = collectionController;
    self.delegate = collectionController;
    self.webView.delegate = self;
    [self login];
}

#pragma mark Login

- (void)login {
   [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@client_id=%@&redirect_uri=%@&response_type=token", INSTAGRAM_AUTH_URL, INSTAGRAM_CLIENT_ID, INSTAGRAM_REDIRECT_URI];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlString = request.URL.absoluteString;
    [self checkForAccessToken:urlString];
    return YES;
}

#pragma mark - Helper functions

- (void)checkForAccessToken:(NSString *)urlString {
    if ([urlString rangeOfString:@"#access_token="].location != NSNotFound) {
        NSArray* array = [urlString componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            urlString = [array lastObject];
        }
            NSArray* values = [urlString componentsSeparatedByString:@"="];
            if ([values count] == 2) {
                NSString* key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    self.token = [values lastObject];
                    
                    if (self.token) {
                        [self.delegate accessTokenFound:self.token];
                        [self showCollectionController];
                        
                }
            }
        }
    }
}

- (void)showCollectionController {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
    UIViewController* mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    [mainVC presentViewController:self.collectionController
                         animated:YES
                       completion:nil];
}

@end
