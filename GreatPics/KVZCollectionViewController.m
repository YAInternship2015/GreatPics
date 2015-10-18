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
#import "KVZCoreDataManager.h"
#import <CoreData/CoreData.h>
#import "KVZLoginViewController.h"


@interface KVZCollectionViewController () <KVZDataSourceDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) KVZDataSource *dataSource;

@end

@implementation KVZCollectionViewController

#pragma mark - Main

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dataSource = [[KVZDataSource alloc] init];
        self.dataSource.delegate  = self;
    }
    return self;
}

- (KVZServerManager *)serverManager {
    return [KVZServerManager sharedManager];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    [self.serverManager loadFirstPageOfPosts];
}


#pragma mark - KVZDataSourceDelegate

- (void)dataSourceWillDisplayLastCell:(KVZDataSource *)dataSource {
    [self.serverManager loadNextPageOfPosts];
}

- (void)dataSourceDidChangeContent:(KVZDataSource *)dataSource{
    [self.collectionView reloadData];
}

@end
