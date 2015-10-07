//
//  KVZInstaPost+CoreDataProperties.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/6/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KVZInstaPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVZInstaPost (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *identifier;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *text;

@end

NS_ASSUME_NONNULL_END
