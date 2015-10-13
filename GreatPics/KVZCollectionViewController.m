//
//  ViewController.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZCollectionViewController.h"
#import "KVZDataSource.h"
#import "KVZServerManager.h"
#import "KVZInstaPost.h"
#import "KVZCoreDataManager.h"
#import "KVZInstaPostManager.h"
#import <CoreData/CoreData.h>



@interface KVZCollectionViewController () <KVZLoginViewControllerDelegate, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) KVZDataSource *dataSource;
@property (nonatomic, strong) KVZServerManager *serverManager;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation KVZCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Instagram API

- (void)getPicsFromServerWithToken:token {
    [self.serverManager getPicsWithToken:token
                                           onSuccess:^(NSArray *pics) {
                                                    for (NSDictionary* dict in pics) {
                                                        KVZInstaPostManager *manager = [[KVZInstaPostManager alloc]init];
                                                        [manager checkForEqualPosts:dict];
                                              }
                                           }
                                           onFailure:^(NSError *error, NSInteger statusCode) {
                                               NSLog(@"error - %@, status code - %lu", [error localizedDescription], statusCode);
                                           }];
}

#pragma mark - KVZLoginViewControllerDelegate

- (void)accessTokenFound:(NSString *)token {
    KVZDataSource *dataSource = [[KVZDataSource alloc]init];
    self.dataSource = dataSource;
    self.collectionView.dataSource = dataSource;
    dataSource.fetchedResultsController.delegate = self;
    
    NSManagedObjectContext *moc = [[KVZCoreDataManager sharedManager] managedObjectContext];
    self.managedObjectContext = moc;

    self.serverManager = [KVZServerManager sharedManager];
   
    self.token = token;
    [self getPicsFromServerWithToken:self.token];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    KVZCoreDataManager *dataManager = [KVZCoreDataManager sharedManager];
    if (indexPath.row == ([dataManager allObjects].count - 1)) {
        [self getPicsFromServerWithToken:self.token];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UICollectionView *collectionView = self.collectionView;
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            [collectionView insertItemsAtIndexPaths:@[newIndexPath]];
        }
            break;
        case NSFetchedResultsChangeDelete: {
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
            break;
        case NSFetchedResultsChangeUpdate: {
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
            break;
        default: {
        }
    }
}



@end
