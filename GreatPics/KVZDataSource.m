//
//  KVZDataSource.m
//  GreatPics
//
//  Created by kateryna.zaikina on 9/30/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZDataSource.h"
#import "KVZCollectionViewCell.h"
#import "KVZCoreDataManager.h"
#import "KVZPostTest.h"
#import "UIKit+AFNetworking.h"
#import "KVZCollectionViewCell.h"
#import "KVZInstaPost.h"


@interface KVZDataSource ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation KVZDataSource 


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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"identifier" ascending:YES];
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
    return 1;
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
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:post.imageURL]];
    
    __weak KVZCollectionViewCell* weakCell = cell;
    
    weakCell.imageView.image = nil;
    NSLog(@"%@", weakCell.imageView);
    
    [weakCell.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                 weakCell.imageView.image = image;
                 NSLog(@"%@", image);
                 [weakCell layoutSubviews];
             }
             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                 
             }];
    

}

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return [self.picsArray count];
//
//}
//
//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//
//    
//    static NSString* identifier = @"Cell";
//    
//    KVZCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];


//    KVZPostTest* post = [self.picsArray objectAtIndex:indexPath.row];
//    NSLog(@"post - %@", post.idCode);
//    
//    
//    NSLog(@"post.id - %@ post.text - %@ post URL - %@", post.idCode, post.text, post.imageURL);
//        
//        NSURLRequest* request = [NSURLRequest requestWithURL:post.imageURL];
//        
//        __weak KVZCollectionViewCell* weakCell = cell;
//        
//        weakCell.imageView.image = nil;
//        NSLog(@"%@", weakCell.imageView);
//        
//        [weakCell.imageView
//         setImageWithURLRequest:request
//         placeholderImage:nil
//         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//             weakCell.imageView.image = image;
//             NSLog(@"%@", image);
//             [weakCell layoutSubviews];
//         }
//         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//             
//         }];

       

  //  }
    
//    return cell;
//
//}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                               {
                    NSLog(@"Подгружаю !");
                    
                   // [];
                }
            }
    
}



@end

