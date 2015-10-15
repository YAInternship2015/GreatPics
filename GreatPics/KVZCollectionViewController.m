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
#import "KVZInstaPostManager.h"
#import <CoreData/CoreData.h>
#import "KVZLoginViewController.h"


@interface KVZCollectionViewController () <KVZLoginViewControllerDelegate, KVZDataSourceDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) KVZDataSource *dataSource;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSDictionary *pagination;

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

- (NSManagedObjectContext *)managedObjectContext {
    return [[KVZCoreDataManager sharedManager] managedObjectContext];
}

- (KVZServerManager *)serverManager {
    return [KVZServerManager sharedManager];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
}

#pragma mark - Instagram API

- (void)getPicsFromServerWithToken:(NSString *)token maxTagID:(NSString *)maxTagID {
    __weak KVZCollectionViewController *weakSelf = self;
    [self.serverManager recentPostsForTagName:@"workhardanywhere"
                                        count:20
                                     maxTagID:maxTagID
                                  accessToken:token
                                    onSuccess:^(id responseObject) {
                                        KVZInstaPostManager *manager = [[KVZInstaPostManager alloc] init];
                                        weakSelf.pagination = [responseObject valueForKey:@"pagination"];
                                        [manager importPosts:[responseObject valueForKey:@"data"]];
                                        
                                    } onFailure:^(NSError *error) {
                                        NSLog(@"error - %@, status code - %lu", [error localizedDescription], [error code]);
                                    }];
}

#pragma mark - KVZLoginViewControllerDelegate

- (void)loginViewController:(KVZLoginViewController *)controller didAccessWithToken:(NSString *)token {
    self.token = token;
    [self getPicsFromServerWithToken:token maxTagID:nil];
}

#pragma mark - KVZDataSourceDelegate

- (void)dataSourceWillDisplayLastCell:(KVZDataSource *)dataSource {
    [self getPicsFromServerWithToken:self.token maxTagID:self.pagination[@"next_max_tag_id"]];
}

- (void)dataSourceDidChangeContent:(KVZDataSource *)dataSource{
    [self.collectionView reloadData];
}

@end
