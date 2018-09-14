//
//  ProductViewController.h
//  ShopifyMobileChallenge
//
//  Created by Div Bhasin on 2018-09-12.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Products.h"

@interface ProductViewController : UITableViewController

@property (strong, nonatomic) NSString *tag;
@property (strong, nonatomic) NSArray *matchedProducts;

@end
