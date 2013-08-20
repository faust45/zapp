//
//  ViewController.h
//  ZApp
//
//  Created by Anton Shastun on 7/17/13.
//  Copyright (c) 2013 Anton Shastun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,
                                              UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *dataList;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//NSString *deviceToken;

- (void) loadPage: (NSString*) url;
- (void) setDeviceToken: (NSString*) deviceToken;

@end
