//
//  KVZServerManager.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZServerManager.h"
#import <AFNetworking/AFNetworking.h>
#import "KVZInstaPostManager.h"

@interface KVZServerManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSDictionary *pagination;

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

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURL *URL = [NSURL URLWithString:@"https://api.instagram.com/v1/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:URL];
    }
    return self;
}

#pragma mark - Instagram API

- (void)recentPostsForTagName:(NSString *)tagName
                        count:(NSUInteger)count
                     maxTagID:(NSString *)maxTagID
                    onSuccess:(void(^)(id responseObject))success
                    onFailure:(void(^)(NSError *error))failure {
    NSString *URLString = [NSString stringWithFormat:@"tags/%@/media/recent", tagName];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    if (self.accessToken) {
        parameters[@"access_token"] = self.accessToken;
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

- (void)loadFirstPageOfPosts {
    [self loadPostsWithMaxTagID:nil];
}

- (void)loadNextPageOfPosts {
    [self loadPostsWithMaxTagID:self.pagination[@"next_max_tag_id"]];
}

- (void)loadPostsWithMaxTagID:(NSString *)maxTagID {
    static const NSInteger numberOfPostLoaded = 20;
    __weak KVZServerManager *weakSelf = self;
    [self recentPostsForTagName:@"workhardanywhere"
                          count:numberOfPostLoaded
                       maxTagID:maxTagID
                      onSuccess:^(id responseObject) {
                          KVZInstaPostManager *manager = [[KVZInstaPostManager alloc] init];
                          weakSelf.pagination = [responseObject valueForKey:@"pagination"];
                          [manager importPosts:[responseObject valueForKey:@"data"]];
                          
                      } onFailure:^(NSError *error) {
                          NSLog(@"error - %@, status code - %lu", [error localizedDescription], [error code]);
                      }];
}

@end
