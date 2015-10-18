//
//  KVZNavigationManager.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/16/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZNavigationManager.h"
#import "KVZServerManager.h"
#import "KVZCollectionViewController.h"
#import "KVZLoginViewController.h"

@implementation KVZNavigationManager

- (void)createLoginControllerInWindow:(UIWindow *)window {
    void(^loginCompletionBlock)(NSString *) = ^(NSString *accessToken) {
        if (accessToken) {
            KVZServerManager *serverManager = [KVZServerManager sharedManager];
            serverManager.accessToken = accessToken;
            [self createCollectionViewControllerInWindow:window];
        }
    };
    
    KVZLoginViewController *loginViewController = [KVZLoginViewController loginControllerWithCompletionBlock:loginCompletionBlock];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    window.rootViewController = navigationController;
}

- (void)createCollectionViewControllerInWindow:(UIWindow *)window {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    KVZCollectionViewController *collectionController = (KVZCollectionViewController *)[sb instantiateViewControllerWithIdentifier:NSStringFromClass([KVZCollectionViewController class])];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:collectionController];
    window.rootViewController = navigationController;
}

@end
