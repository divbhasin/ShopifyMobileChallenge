//
//  ViewController.h
//  ShopifyMobileChallenge
//
//  Created by Div Bhasin on 2018-09-12.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"
#import "ProductViewController.h"

@interface ViewController : UITableViewController

@property (strong, nonatomic) Products *products;
@property NSInteger *selected;

@end

