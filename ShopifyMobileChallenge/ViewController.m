//
//  ViewController.m
//  ShopifyMobileChallenge
//
//  Created by Div Bhasin on 2018-09-12.
//  Copyright © 2018 Div Bhasin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSString *selectedTag;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Tags";
    
    [self fetchTags];
}

- (void)fetchTags {
    // fetch tags from Spotify API here and set self.tags to the data
    NSURL *url = [NSURL URLWithString:@"https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"];

    NSURLSessionDataTask *fetchTags = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // 4: Handle response here
                                              NSLog(@"%@", data);
                                              NSError *jsonError;
                                              
                                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                                              
                                              NSArray *products = json[@"products"];
                                              
                                              self.products = [Products sharedManager];
                                              [self.products initProducts:products];
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.tableView reloadData];
                                              });
                                          }];
    
    [fetchTags resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.products) {
        return [self.products getAllProducts].count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    NSArray *tags = [[[self.products getAllTags] array] mutableCopy];
    
    tags = [tags sortedArrayUsingSelector:@selector(compare:)];
    
    if (indexPath.row < [tags count]) {
        cell.textLabel.text = [[tags objectAtIndex:indexPath.row] capitalizedString];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segue"])
    {
        ProductViewController *pvc = [segue destinationViewController];
        pvc.tag = [[NSString alloc] initWithString:selectedTag];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedTag = [[[[self.products getAllTags] array] mutableCopy] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"segue" sender:self];
}


@end
