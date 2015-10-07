//
//  KVZServerManager.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZServerManager.h"
#import "AFNetworking.h"
#import "KVZLoginViewController.h"

@interface KVZServerManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation KVZServerManager

+ (KVZServerManager *)sharedManager {
    
    static KVZServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KVZServerManager alloc] init];
    });
    return manager;
}

- (void)getPicsWithToken:(NSString *)token
             onSuccess:(void(^)(NSArray *pics))success
             onFailure:(void(^)(NSError *error, NSInteger statusCode))failure {
    
    NSString *tagString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/nature/media/recent?access_token=%@", token];
    
    [[[AFHTTPSessionManager alloc]init] GET:tagString
                                 parameters:@{@"count" : @"20"}
                                    success:^(NSURLSessionDataTask *operation, id responseObject) {
                                        NSLog(@"JSON: %@", responseObject);
                                        NSArray *picsArray = [responseObject objectForKey:@"data"];
                                        NSLog(@"picsArray - %@", picsArray);
                                    }
                                    failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                        NSLog(@"Error: %@", error);
                                    }];
    
}

@end

/*
https://api.instagram.com/v1/tags/{tag-name}/media/recent?access_token=ACCESS-TOKEN
/tags/tag-name/media/recent
PARAMETERS
COUNT	Count of tagged media to return.
MIN_TAG_ID	Return media before this min_tag_id.
MAX_TAG_ID	Return media after this max_tag_id.
*/