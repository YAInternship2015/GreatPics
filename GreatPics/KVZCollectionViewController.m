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


@interface KVZCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *picsArray;

@end

@implementation KVZCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KVZDataSource *dataSource = [[KVZDataSource alloc]init];
    self.collectionView.dataSource = dataSource;
    
    self.picsArray =[NSMutableArray array];
    
}

-(void)dealloc {
    NSLog(@"dealoc CC");
}

#pragma mark - API

- (void)getPicsFromServerWithToken:token {
    [[KVZServerManager sharedManager] getPicsWithToken:token
                                           onSuccess:^(NSArray *pics) {
                                               [self.picsArray addObjectsFromArray:pics];
                                              // [self.collectionView reloadData];
                                           }
                                           onFailure:^(NSError *error, NSInteger statusCode) {
                                               NSLog(@"error - %@, status code - %lu", [error localizedDescription], statusCode);
                                           }];
    
}

#pragma mark - KVZLoginViewControllerDelegate

- (void)accessTokenFound:(NSString *)token {
    
    [self getPicsFromServerWithToken:token];

}
- (void)displayRequired {

}
- (void)closeTapped {

}

@end
