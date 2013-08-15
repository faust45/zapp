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
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

    NSString *token = [NSString stringWithFormat:@"DeviceToken=%@", [self deviceToken]];
    //[urlRequest setValue: token forHTTPHeaderField: @"Set-Cookie"]; 

    NSDictionary *properties = [NSMutableDictionary
        dictionaryWithObjectsAndKeys:@".red5demo.com", NSHTTPCookieDomain,
        @"deviceToken", NSHTTPCookieName,
        @"/", NSHTTPCookiePath,
        [self deviceToken], NSHTTPCookieValue,
        @"2014-05-03 21:02:41 -0700", NSHTTPCookieExpires, nil];
    NSHTTPCookie *myCookie = [NSHTTPCookie cookieWithProperties:properties];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie: myCookie];

    [[self webView] loadRequest: urlRequest];
    [self webView].autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)inType {
    NSLog(@"event webview");
    if ( inType == UIWebViewNavigationTypeFormSubmitted ) {
        //[[UIApplication sharedApplication] openURL:[request URL]];
        NSLog(@"Send form %@", [request URL]);
        return YES;
    }

    if ( inType == UIWebViewNavigationTypeFormResubmitted ) {
        //[[UIApplication sharedApplication] openURL:[request URL]];
        return YES;
    }

    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *) indexPath 
{
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
