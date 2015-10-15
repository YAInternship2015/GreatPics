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

@implementation KVZInstaPostManager

- (NSManagedObjectContext *)managedObjectContext {
    return [[KVZCoreDataManager sharedManager] managedObjectContext];
}

- (void)importPosts:(NSArray *)posts {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KVZInstaPost"
                                              inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSArray *identifiers = [posts valueForKey:@"id"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier in %@", identifiers];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchedObjectsArray = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    NSArray *fetchedObjectsIdentifiers = [fetchedObjectsArray valueForKey:@"identifier"];
    NSDictionary *fetchedObjectsDictionary = [NSDictionary dictionaryWithObjects:fetchedObjectsArray
                                                                         forKeys:fetchedObjectsIdentifiers];
    if (!error) {
        [posts enumerateObjectsUsingBlock:^(NSDictionary *postDictionary, NSUInteger idx, BOOL * stop) {
            KVZInstaPost *post;
            if (![fetchedObjectsDictionary objectForKey:[postDictionary valueForKey:@"id"]]) {
                post = [NSEntityDescription insertNewObjectForEntityForName:@"KVZInstaPost"
                                                     inManagedObjectContext:[self managedObjectContext]];
            } else {
                post = [fetchedObjectsDictionary objectForKey:[post valueForKey:@"id"]];
            }
            [post updateWithDictionary:postDictionary];
        }];
        
        NSError *error;
        [self.managedObjectContext save:&error];
        
        if (error) {
            NSLog(@"save with error: %@", error);
        }
    } else {
        NSLog(@"executeFetchRequest with error: %@", error);
    }
}

@end
