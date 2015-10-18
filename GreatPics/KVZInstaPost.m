//
//  KVZInstaPost.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/6/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZInstaPost.h"

@implementation KVZInstaPost

- (void)updateWithDictionary:(NSDictionary *)responseObject {
    self.identifier = [responseObject objectForKey:@"id"];
    self.text = [responseObject valueForKeyPath:@"caption.text"];
    self.imageURL = [responseObject valueForKeyPath:@"images.standard_resolution.url"];
}

@end
