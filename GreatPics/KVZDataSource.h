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

@class KVZDataSource;

@protocol KVZDataSourceDelegate <NSObject>

- (void)dataSourceWillDisplayLastCell:(KVZDataSource *)dataSource;
- (void)dataSourceDidChangeContent:(KVZDataSource *)dataSource;

@end

@interface KVZDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, weak) id <KVZDataSourceDelegate> delegate;

@end
