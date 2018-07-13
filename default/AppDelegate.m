//
//  AppDelegate.m
//  birthday-keeper
//
//  Created by   chironyf on 2018/3/11.
//  Copyright © 2018年 chironyf. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "BirthdayTableViewController.h"
#import "Singleton.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:settings];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *birthdayData = [defaults objectForKey:@"birthdayInfoList"];
    if (birthdayData == nil) {
        Singleton.sharedInstance.birthdayInfo = [NSMutableArray array];
    } else {
        Singleton.sharedInstance.birthdayInfo = (NSMutableArray<BirthdayCellModel *> *)[NSKeyedUnarchiver unarchiveObjectWithData:birthdayData];
    }
    BirthdayTableViewController *btvc = [[BirthdayTableViewController alloc] init];
    btvc.birthdayInfo = [Singleton.sharedInstance.birthdayInfo mutableCopy];
//    Singleton.sharedInstance.birthdayInfo = btvc.birthdayInfo;
    RootViewController *viewController = [[RootViewController alloc] initWithRootViewController:btvc];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setBackgroundColor:UIColor.blackColor];
    [_window setRootViewController:viewController];
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSData *encodedBirthdayInfo = [NSKeyedArchiver archivedDataWithRootObject:Singleton.sharedInstance.birthdayInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedBirthdayInfo forKey:@"birthdayInfoList"];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSData *encodedBirthdayInfo = [NSKeyedArchiver archivedDataWithRootObject:Singleton.sharedInstance.birthdayInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedBirthdayInfo forKey:@"birthdayInfoList"];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    application.applicationIconBadgeNumber = 0;
}

@end
