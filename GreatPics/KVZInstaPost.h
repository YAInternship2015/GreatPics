//
//  KVZInstaPost.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/6/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVZInstaPost : NSManagedObject

- (void)setValuesWithServerResponse:(NSDictionary *)responseObject;

@end

NS_ASSUME_NONNULL_END

#import "KVZInstaPost+CoreDataProperties.h"
