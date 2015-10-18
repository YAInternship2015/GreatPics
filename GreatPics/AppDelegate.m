//
//  AppDelegate.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "AppDelegate.h"
#import "KVZNavigationManager.h"
#import "KVZCollectionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    KVZNavigationManager *navigationManager = [[KVZNavigationManager alloc]init];
    [navigationManager createLoginControllerInWindow:window];
    [window makeKeyAndVisible];
    return YES;
}

@end
