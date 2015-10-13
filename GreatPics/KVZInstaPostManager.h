//
//  KVZInstaPostManager.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/13/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVZInstaPostManager : NSObject

- (void)checkForEqualPosts:(NSDictionary *)serverResponse;

@end
