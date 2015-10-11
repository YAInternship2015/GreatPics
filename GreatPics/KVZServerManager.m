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
#import "KVZPostTest.h"
#import "FastEasyMapping.h"
#import "KVZCoreDataManager.h"
#import "KVZInstaPost.h"

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

- (instancetype)init {
    self = [super init];
    if (self) {
//        NSURL *url = [[NSURL alloc]initWithString:@"https://api.instagram.com/v1"];
//        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
//        self.sessionManager = manager;
    }
    return self;


}

- (void)getPicsWithToken:(NSString *)token
             onSuccess:(void(^)(NSArray *pics))success
             onFailure:(void(^)(NSError *error, NSInteger statusCode))failure {
    
    NSManagedObjectContext *moc = [[KVZCoreDataManager sharedManager] managedObjectContext];
    
    NSString *tagString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/nature/media/recent?access_token=%@",token];
    
    
    
    [[[AFHTTPSessionManager alloc] init] GET:tagString
                                 parameters:@{@"count" : @20}
                                    success:^(NSURLSessionDataTask *operation, id responseObject) {
                                       
                                        NSArray *dictsArray = [responseObject objectForKey:@"data"];
                                        NSLog(@"picsArray - %@", dictsArray);
                                        NSMutableArray *objectsArray = [NSMutableArray array];
                                        for (NSDictionary* dict in dictsArray) {
                                            
                                            
                                            KVZInstaPost *instaPost = [NSEntityDescription insertNewObjectForEntityForName:@"KVZInstaPost" inManagedObjectContext:moc];
                                            [instaPost setValuesWithServerResponse:dict];
                                            NSError *error;
                                             [moc save:&error];
                                            NSLog(@"post %ld : %@", [dictsArray indexOfObject:dict], instaPost);
                                          //  [objectsArray addObject:instaPost];
                                        }
/*
                                            FEMMapping *mapping = [KVZPostTest defaultMapping];
                                            KVZPostTest *post = [FEMDeserializer objectFromRepresentation:responseObject mapping:mapping];
                                        
                                        NSArray *dictsArray = [responseObject objectForKey:@"data"];
                                        NSLog(@"picsArray - %@", dictsArray);
                                        
                                        NSMutableArray *objectsArray = [NSMutableArray array];
                                        for (NSDictionary *dict in dictsArray) {
                                            FEMMapping *mapping = [KVZPostTest defaultMapping];
                                            KVZPostTest *post = [FEMDeserializer objectFromRepresentation:dict mapping:mapping];
                                            [objectsArray addObject:post];

                                        }
*/
 
                                        if (success) {
                                            
                                            success(objectsArray);
                                           
                                        }

                                    }
                                    failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                        NSLog(@"Error: %@", error);
                                    }];
    
//    NSArray *array = [NSArray arrayWithArray:objectsArray];
//    return array;
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