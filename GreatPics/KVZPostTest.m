//
//  KVZPostTest.m
//  GreatPics
//
//  Created by kateryna.zaikina on 10/8/15.
//  Copyright © 2015 kateryna.zaikina. All rights reserved.
//

#import "KVZPostTest.h"


@implementation KVZPostTest

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        self.idCode = [responseObject objectForKey:@"id"];
        NSDictionary *captionDict = [responseObject objectForKey:@"caption"];
        self.text = [captionDict objectForKey:@"text"];
        NSDictionary *imagesDict = [responseObject objectForKey:@"images"];
        
        NSDictionary *imageDict = [imagesDict objectForKey:@"standard_resolution"];
        NSString* urlString = [imageDict objectForKey:@"url"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
            NSLog(@"%@", self.imageURL);
        }
    }
    return self;
}

//+ (FEMMapping *)defaultMapping {
//    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[KVZPostTest class]];
//    mapping.primaryKey = @"identifier";
//    
//    [mapping addAttributesFromDictionary:@{@"idCode": @"id"}];
//    [mapping addAttributesFromArray:@[@"text"]];
//    [mapping addAttributesFromDictionary:@{@"imageURL": @"standard_resolution"}];
//    
//    return mapping;
//}




@end
