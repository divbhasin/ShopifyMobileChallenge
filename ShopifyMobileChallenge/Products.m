//
//  Products.m
//  ShopifyMobileChallenge
//
//  Created by Div Bhasin on 2018-09-12.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Products.h"

@implementation Products

+ (id)sharedManager {
    static Products *products = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        products = [[self alloc] init];
    });
    return products;
}

- (void) initProducts:(NSArray *)products {
    self.products = [[NSArray alloc] initWithArray:products];
}

- (NSArray *)getAllProducts {
    return _products;
}

- (NSMutableOrderedSet *)getAllTags {
    NSMutableOrderedSet *tags = [[NSMutableOrderedSet alloc] init];
    
    for (NSDictionary *product in self.products) {
        NSArray *foundTags = [product[@"tags"] componentsSeparatedByString:@", "];
        for (NSString *tag in foundTags) {
            if (![tags containsObject:tag]) {
                [tags addObject:tag];
            }
        }
    }
    
    return tags;
}

- (NSArray *)getAllProductsWithTag:(NSString *)findTag {
    NSMutableArray *matchedProducts = [[NSMutableArray alloc] init];
    
    for (NSDictionary *product in self.products) {
        NSArray *foundTags = [product[@"tags"] componentsSeparatedByString:@", "];
        for (NSString *tag in foundTags) {
            if ([findTag isEqualToString:tag]) {
                [matchedProducts addObject:product];
            }
        }
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    [matchedProducts sortUsingDescriptors:@[sortDescriptor]];
    
    return matchedProducts;
}

@end
