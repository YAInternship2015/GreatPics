//
//  KVZServerManager.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZServerManager.h"
#import <AFNetworking/AFNetworking.h>

@interface KVZServerManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation KVZServerManager

#pragma mark - Class

+ (KVZServerManager *)sharedManager {
    static KVZServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KVZServerManager alloc] init];
    });
    return manager;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *URL = [NSURL URLWithString:@"https://api.instagram.com/v1/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    }
    return self;
}

- (void)recentPostsForTagName:(NSString *)tagName
                        count:(NSUInteger)count
                     maxTagID:(NSString *)maxTagID
                  accessToken:(NSString *)accessToken
                    onSuccess:(void(^)(id responseObject))success
                    onFailure:(void(^)(NSError *error))failure {
    
    NSString *URLString = [NSString stringWithFormat:@"tags/%@/media/recent", tagName];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
       if (accessToken) {
        parameters[@"access_token"] = accessToken;
    }
    parameters[@"count"] = @(count);
    if (maxTagID) {
        parameters[@"max_tag_id"] = maxTagID;
    }
    
    [self.sessionManager GET:URLString
                  parameters:[parameters copy]
                     success:^(NSURLSessionDataTask *operation, id responseObject) {
                         if (success) {
                             success(responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask *operation, NSError *error) {
                         if (failure) {
                             failure(error);
                         }
                     }];
}

@end
