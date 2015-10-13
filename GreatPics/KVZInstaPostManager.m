//
//  KVZInstaPostManager.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/13/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZInstaPostManager.h"
#import "KVZCoreDataManager.h"
#import "KVZInstaPost.h"

@interface KVZInstaPostManager ()
@property (nonatomic, strong) KVZCoreDataManager *dataManager;
@end

@implementation KVZInstaPostManager

-(instancetype)init{
    self = [super init];
    if (self) {
        KVZCoreDataManager *dataManager = [KVZCoreDataManager sharedManager];
        self.dataManager = dataManager;
    }
    return self;
}

-(void)createNewInstaModel:(NSDictionary *)serverResponse{
    KVZInstaPost *instaPost = [NSEntityDescription insertNewObjectForEntityForName:@"KVZInstaPost" inManagedObjectContext:self.dataManager.managedObjectContext];
    [instaPost setValuesWithServerResponse:serverResponse];
    NSError *error;
    [self.dataManager.managedObjectContext save:&error];
}

- (void)checkForEqualPosts:(NSDictionary *)serverResponse {
    NSString *identifier = [serverResponse objectForKey:@"id"];
    NSArray *postsArray = [self.dataManager allObjects];
    for (KVZInstaPost *post in postsArray) {
        if (![post.identifier isEqualToString:identifier]) {
            [self createNewInstaModel:serverResponse];
        }
    }
}

@end
