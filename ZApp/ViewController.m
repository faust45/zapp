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

- (void) viewDidLoad {
  [super viewDidLoad];

  NSLog(@"load view controller");

  self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.webView.delegate = self;

  [self loadPage: @"/client"];

  // Do any additional setup after loading the view, typically from a nib.
}

- (void) setDeviceToken: (NSString*) deviceToken {
    NSDictionary *properties = [NSMutableDictionary
      dictionaryWithObjectsAndKeys:@".red5demo.com", NSHTTPCookieDomain,
      @"deviceToken", NSHTTPCookieName,
      @"/", NSHTTPCookiePath,
      deviceToken, NSHTTPCookieValue,
      @"2014-05-03 21:02:41 -0700", NSHTTPCookieExpires, nil];
    NSHTTPCookie *myCookie = [NSHTTPCookie cookieWithProperties:properties];

    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie: myCookie];
}

- (void) loadPage: (NSString*) page {
    NSMutableString* path = [NSMutableString string];
    [path appendFormat:@"%@/%@", @"http://aggress.red5demo.com", page];

    NSURL *url = [NSURL URLWithString: path];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [self.webView loadRequest: urlRequest];
}

- (void) application: (UIApplication *) application 
         didReceiveRemoteNotification: (NSDictionary *) userInfo { 

      NSLog(@"in View Alert message: %@", [[userInfo valueForKey:@"aps"] valueForKey:@"alert"]);
      NSLog(@"in View Alert message: %@", userInfo);
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	NSString *errorString = [error localizedDescription];
	NSLog(@"webView:didFailLoadWithError: %@", errorString );
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
