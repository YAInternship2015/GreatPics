//
//  KVZLoginViewController.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/2/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^KVZLoginCompletionBlock)(NSString* accessToken);

@interface KVZLoginViewController : UIViewController

+ (KVZLoginViewController *)loginControllerWithCompletionBlock:(KVZLoginCompletionBlock)completionBlock;

@end
