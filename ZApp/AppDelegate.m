//
//  AppDelegate.m
//  ZApp
//
//  Created by Anton Shastun on 7/17/13.
//  Copyright (c) 2013 Anton Shastun. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "Reachability.h"
#import "Reachability.m"

@implementation AppDelegate

- (BOOL) respondsToSelector: (SEL) sel {
    //NSLog(@"Debug - %@", NSStringFromSelector(sel));
    return [super respondsToSelector:(sel)];
}

- (void)applicationDidFinishLaunching:(UIApplication *)app {
   // other setup tasks here....
}

- (BOOL) application: (UIApplication *) application 
         didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

    if (networkStatus == NotReachable) {
        Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
        
        // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
        //reach.reachableOnWWAN = NO;
        
        // Here we set up a NSNotification observer. The Reachability that caused the notification
        // is passed in the object parameter
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(handleNetworkChange:) 
                                                     name:kReachabilityChangedNotification 
                                                   object:nil];
        
        [reach startNotifier];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil)
                                                        message:NSLocalizedString(@"There IS NO internet connection", nil)
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                              otherButtonTitles:nil];
        [alert show];
    } else {        
    }

   self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
		(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
   return YES;
}

- (void) application: (UIApplication*) application 
         didReceiveRemoteNotification: (NSDictionary*) userInfo { 

    NSString *msg = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    NSLog(@"Alert message: %@", msg);
    NSLog(@"Alert message: %@", userInfo);

    if ( application.applicationState == UIApplicationStateActive ) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message from coach", nil)
                                                     message:NSLocalizedString(msg, nil)
                                                    delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"NO", nil)
                                           otherButtonTitles: nil];

      [alert show];
    } else {
      [self.viewController loadPage: [userInfo valueForKey:@"url"]];
    }
}

- (void)handleNetworkChange:(NSNotification *)notice{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [networkReachability currentReachabilityStatus];
    if (status == NotReachable) {
        NSLog(@"connection off");        
    } else {
        NSLog(@"connection on");        
    }
}

- (void) application: (UIApplication *) application 
         didRegisterForRemoteNotificationsWithDeviceToken: (NSData *) deviceToken {

    ViewController* vc1 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [vc1 setDeviceToken: [deviceToken description]];
 
    self.window.rootViewController = vc1;
    [self.window makeKeyAndVisible];

    self.viewController = vc1;

    NSLog(@"My token is: %@", deviceToken);
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
