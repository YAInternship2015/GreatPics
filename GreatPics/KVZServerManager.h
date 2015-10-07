//
//  KVZServerManager.h
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KVZServerManager : NSObject

+(KVZServerManager *)sharedManager;

- (void)getPicsWithToken:(NSString *)token
             onSuccess:(void(^)(NSArray *pics))success
             onFailure:(void(^)(NSError *error, NSInteger statusCode))failure;

@end
