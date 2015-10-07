//
//  KVZDataSource.h
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface KVZDataSource : NSObject <UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSMutableArray *picsArray;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@end
