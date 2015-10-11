//
//  KVZInstaPost.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/6/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZInstaPost.h"
#import "FastEasyMapping.h"

@implementation KVZInstaPost

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"KVZInstaPost"];
    mapping.rootPath = @"data";
    mapping.primaryKey = @"identifier";

    [mapping addAttributesFromDictionary:@{@"identifier": @"id"}];
    [mapping addAttributesFromArray:@[@"text"]];
    [mapping addAttributesFromDictionary:@{@"imageURL": @"standard_resolution"}];
    
    return mapping;
}

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
