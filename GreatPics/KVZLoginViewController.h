//
//  KVZLoginViewController.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/2/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KVZLoginViewController;

@protocol KVZLoginViewControllerDelegate <NSObject>

- (void)loginViewController:(KVZLoginViewController *)controller didAccessWithToken:(NSString *)token;

@end

@interface KVZLoginViewController : UIViewController 

@property (nonatomic, weak) id <KVZLoginViewControllerDelegate> delegate;

@end
