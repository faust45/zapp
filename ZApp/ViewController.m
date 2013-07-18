//
//  ViewController.m
//  ZApp
//
//  Created by Anton Shastun on 7/17/13.
//  Copyright (c) 2013 Anton Shastun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://aggress.red5demo.com/client"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [[self webView] loadRequest: urlRequest];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *) indexPath 
{
        NSLog(@"debug ! %d", indexPath.row);
        NSArray *array = [NSArray arrayWithObjects:@"apples", @"bananas", @"milk", nil];

        UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
        if( nil == cell ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = array[indexPath.row];

        return cell;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section 
{
    return 3;
}

- (void)dataList:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    [tv deselectRowAtIndexPath:indexPath animated:YES];
}
@end
