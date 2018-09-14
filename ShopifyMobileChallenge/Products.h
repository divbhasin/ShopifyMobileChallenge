//
//  Products.h
//  ShopifyMobileChallenge
//
//  Created by Div Bhasin on 2018-09-12.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

@interface Products : NSObject

@property (strong, nonatomic) NSArray *products;
- (NSMutableOrderedSet *)getAllTags;
- (NSArray *)getAllProductsWithTag: (NSString *)findTag;
- (void)initProducts:(NSArray *)products;
- (NSArray *)getAllProducts;
+ (id)sharedManager;

@end
