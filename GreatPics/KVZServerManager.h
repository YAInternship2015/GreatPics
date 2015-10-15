//
//  KVZServerManager.h
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVZServerManager : NSObject

+ (KVZServerManager *)sharedManager;

- (void)recentPostsForTagName:(NSString *)tagName
                        count:(NSUInteger)count
                     maxTagID:(NSString *)maxTagID
                  accessToken:(NSString *)accessToken
                    onSuccess:(void(^)(id responseObject))success
                    onFailure:(void(^)(NSError *error))failure;

@end
