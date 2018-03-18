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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    [application registerUserNotificationSettings:settings];

    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    BirthdayTableViewController *btvc = [[BirthdayTableViewController alloc] init];
 
    //读取文件

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *birthdayData = [defaults objectForKey:@"birthdayInfoList"];
    if (birthdayData == nil) {
        externBirthdayInfo = [NSMutableArray array];
    } else {
        externBirthdayInfo = (NSMutableArray<BirthdayCellModel *> *)[NSKeyedUnarchiver unarchiveObjectWithData:birthdayData];
    }
    btvc.birthdayInfo = [externBirthdayInfo mutableCopy];
 
    RootViewController *viewController = [[RootViewController alloc] initWithRootViewController:btvc];
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
    //    NSData *encodedCurBirdSightingList = [NSKeyedArchiver archivedDataWithRootObject:self.masterBirdSightingList];
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:encodedCurBirdSightingList forKey:@"BirdSightingList"];
    NSData *encodedBirthdayInfo = [NSKeyedArchiver archivedDataWithRootObject:externBirthdayInfo];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedBirthdayInfo forKey:@"birthdayInfoList"];
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *birthdayFileName = [path stringByAppendingPathComponent:@"birthdayFileName.plist"];
//
//    NSArray *a = [externBirthdayInfo copy];
//    [a writeToFile:birthdayFileName atomically:YES];
//    NSString *xpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSString *xfileName = [xpath stringByAppendingPathComponent:@"12.plist"];
//
//    NSArray *xarray = @[@"123", @"456", @"789"];
//    [xarray writeToFile:xfileName atomically:YES];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    application.applicationIconBadgeNumber = 0;
    NSLog(@"收到了通知");
}

@end
