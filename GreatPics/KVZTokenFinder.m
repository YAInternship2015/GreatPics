//
//  KVZTokenFinder.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/17/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZTokenFinder.h"

@implementation KVZTokenFinder

+ (NSString *)accessTokenAfterCheck:(NSString *)urlString {
    NSString *accessToken = [NSString string];
    if ([urlString rangeOfString:@"#access_token="].location != NSNotFound) {
        NSArray* array = [urlString componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            urlString = [array lastObject];
        }
        NSArray* values = [urlString componentsSeparatedByString:@"="];
        if ([values count] == 2) {
            NSString* key = [values firstObject];
            
            if ([key isEqualToString:@"access_token"]) {
                accessToken = [values lastObject];
            }
        }
    }
    return accessToken;
}

@end
