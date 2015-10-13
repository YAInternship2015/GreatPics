//
//  KVZInstaPost.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/6/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZInstaPost.h"

@implementation KVZInstaPost

- (void)setValuesWithServerResponse:(NSDictionary *)responseObject{
    self.identifier = [responseObject objectForKey:@"id"];
    
    NSDictionary *captionDict = [responseObject objectForKey:@"caption"];
    self.text = [captionDict objectForKey:@"text"];
    
    NSDictionary *imagesDict = [responseObject objectForKey:@"images"];
    NSDictionary *imageDict = [imagesDict objectForKey:@"standard_resolution"];
    NSString* urlString = [imageDict objectForKey:@"url"];
    self.imageURL = urlString;
}

@end
