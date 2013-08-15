//
//  AppDelegate.m
//  ZApp
//
//  Created by Anton Shastun on 7/17/13.
//  Copyright (c) 2013 Anton Shastun. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL) respondsToSelector: (SEL) sel 
{
    //NSLog(@"Debug - %@", NSStringFromSelector(sel));
    return [super respondsToSelector:(sel)];
}

- (void)applicationDidFinishLaunching:(UIApplication *)app {
   // other setup tasks here....
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //// Override point for customization after application launch.
    //self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //self.window.rootViewController = self.viewController;
    //[self.window makeKeyAndVisible];
    //return YES;
    //UITabBarController* tabBarController = [[UITabBarController alloc] init];
 
   self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
		(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
   return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Convert the binary data token into an NSString (see below for the implementation of this function)
    // Show the device token obtained from apple to the log
    ViewController* vc1 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [vc1 setDeviceToken: [deviceToken description]];
 
   self.window.rootViewController = vc1;
   [self.window makeKeyAndVisible];


    NSLog(@"My token is: %@", deviceToken);
    //[[self.window.rootViewController webView] loadRequest: urlRequest];

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
