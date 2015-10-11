//
//  KVZPostTest.h
//  GreatPics
//
//  Created by kateryna.zaikina on 10/8/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FastEasyMapping.h"

@interface KVZPostTest : NSObject

@property (strong, nonatomic) NSString* idCode;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSURL* imageURL;

- (id) initWithServerResponse:(NSDictionary*) responseObject;




@end
