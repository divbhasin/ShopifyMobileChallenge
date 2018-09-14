//
//  ProductViewController.m
//  ShopifyMobileChallenge
//
//  Created by Div Bhasin on 2018-09-12.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//
#import "ProductViewController.h"

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Products";
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    
}

- (void)loadData {
    Products *products = [Products sharedManager];
    self.matchedProducts = [products getAllProductsWithTag:self.tag];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.matchedProducts) {
        return self.matchedProducts.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.matchedProducts[indexPath.row][@"title"];
    
    NSInteger inventory = [self getTotalInventoryForProduct:self.matchedProducts[indexPath.row]];
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"Inventory: %ld", (long)inventory];
    
    NSURL *url = [NSURL URLWithString:self.matchedProducts[indexPath.row][@"image"][@"src"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    cell.imageView.image = img;
    
    return cell;
}

- (NSInteger)getTotalInventoryForProduct:(NSDictionary *)productInfo {
    NSInteger totalInventory = 0;
    
    for (id variant in productInfo[@"variants"]) {
        totalInventory += [[variant objectForKey:@"inventory_quantity"] integerValue];
    }
    
    return totalInventory;
}

@end
