//
//  KVZServerManager.h
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVZServerManager : NSObject

@property (nonatomic, strong) NSString *accessToken;

+ (KVZServerManager *)sharedManager;
- (void)loadFirstPageOfPosts;
- (void)loadNextPageOfPosts;

@end
