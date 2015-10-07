//
//  KVZDataManager.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/6/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KVZCoreDataManager : NSObject

+ (KVZCoreDataManager *) sharedManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
