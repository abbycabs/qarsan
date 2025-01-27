//
//  AppDelegate.m
//  QarsaniOS
//
//  Created by Michael Weingert on 2015-04-11.
//  Copyright (c) 2015 PBC. All rights reserved.
//

#import "AppDelegate.h"
#import "FirebaseManager.h"

@interface AppDelegate () <FirebaseManagerDelegate>

@end

@implementation AppDelegate

-(void) didFetchStories
{
  UINavigationController *navController =(UINavigationController *) self.window.rootViewController;
  UITabBarController *tabController = navController.viewControllers[0];
  UITableViewController * tableController = tabController.viewControllers[0];
  [tableController.tableView reloadData];
  
  UITableViewController * tableController2 = tabController.viewControllers[1];
  [tableController2.tableView reloadData];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  UINavigationController *navController = (UINavigationController *) self.window.rootViewController;
  [navController.navigationBar setBackgroundColor:[UIColor redColor]];
  navController.navigationBar.barTintColor = [UIColor redColor];
  navController.navigationBar.tintColor = [UIColor whiteColor];
  navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
  
  [[UINavigationBar appearance] setTitleTextAttributes: @{ NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:30.0f] }];
  
 /* [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                          UITextAttributeTextColor: [UIColor whiteColor],
                                                          UITextAttributeTextShadowColor: [UIColor whiteColor],
                                                          UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                          UITextAttributeFont: [UIFont fontWithName:@"Carrois Gothic" size:18.0f]
                                                          }];
  */
  [[FirebaseManager sharedManager] setDelegate: self];
  [[FirebaseManager sharedManager] getNumberOfStories];
  
  
  UIBarButtonItem *addNewButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addNewPost)];
  
  navController.navigationItem.rightBarButtonItem = addNewButton;
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
