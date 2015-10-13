//
//  KVZLoginViewController.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/2/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KVZLoginViewControllerDelegate

- (void)accessTokenFound:(NSString *)token;

@end

@interface KVZLoginViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *token;
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) id <KVZLoginViewControllerDelegate> delegate;

- (void)login;
- (void)checkForAccessToken:(NSString *)urlString;

@end
