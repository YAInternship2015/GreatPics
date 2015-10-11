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



@interface KVZCollectionViewController () <KVZLoginViewControllerDelegate, UICollectionViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSMutableArray *picsArray;
@property (strong, nonatomic) KVZDataSource *dataSource;
@property (nonatomic, strong) KVZServerManager *serverManager;
@property (nonatomic, strong) NSString *token;

@end

@implementation KVZCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // [self authorizeUser];
    

    
}

-(void)dealloc {
    NSLog(@"dealoc CC");
}

#pragma mark - API

- (void)getPicsFromServerWithToken:token {
    [self.serverManager getPicsWithToken:token
                                           onSuccess:^(NSArray *pics) {
//                                               [self.picsArray addObjectsFromArray:pics];
//                                               NSLog(@"collection PICS ARRAY - %@", self.picsArray);
//                                               
//                                              self.dataSource.picsArray = self.picsArray;
//                                               
//                                             [self.collectionView reloadData];
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
   // KVZDataSource *collectionDataSource = (KVZDataSource *)self.collectionView.dataSource;
    dataSource.fetchedResultsController.delegate = self;

    
    self.picsArray =[NSMutableArray array];
    self.serverManager = [KVZServerManager sharedManager];

   
    self.token = token;
    
        [self getPicsFromServerWithToken:self.token];

}

//- (void)authorizeUser{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    KVZLoginViewController *loginController = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
//    
//    [self dismissViewControllerAnimated:YES
//                             completion:nil];
//    
//    UIViewController* mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
//    
//    [mainVC presentViewController:loginController
//                         animated:YES
//                       completion:nil];
//
//}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == ([self.picsArray count] - 1)) {
        NSLog(@"willDisplayCell %ld", indexPath.row);
      //  [self getPicsFromServerWithToken:self.token];
                
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
