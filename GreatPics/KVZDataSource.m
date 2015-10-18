//
//  KVZDataSource.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZDataSource.h"
#import "KVZCoreDataManager.h"
#import "UIKit+AFNetworking.h"
#import "KVZCollectionViewCell.h"
#import "KVZInstaPost.h"


@interface KVZDataSource () <NSFetchedResultsControllerDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation KVZDataSource

#pragma mark - Main

-(instancetype)init {
    self = [super init];
    if (self) {
        self.fetchedResultsController.delegate = self;
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[KVZCoreDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KVZInstaPost" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    static const NSInteger kFetchBatchSize = 20;
    [fetchRequest setFetchBatchSize:kFetchBatchSize];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAtDate" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil cacheName:nil];
    
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    return _fetchedResultsController;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    KVZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(KVZCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    KVZInstaPost *post = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell.imageView setImageWithURL:[NSURL URLWithString:post.imageURL]];
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][indexPath.section];
    NSInteger numberOfItems = [sectionInfo numberOfObjects];
    static const NSInteger numberOfPosts = 3;
    if (indexPath.item == numberOfItems - numberOfPosts) {
        if ([self.delegate respondsToSelector:@selector(dataSourceWillDisplayLastCell:)]) {
            [self.delegate dataSourceWillDisplayLastCell:self];
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    if ([self.delegate respondsToSelector:@selector(dataSourceDidChangeContent:)]) {
        [self.delegate dataSourceDidChangeContent:self];
    }
}

@end

