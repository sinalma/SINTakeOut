//
//  AppDelegate.m
//  SinWaiMai
//
//  Created by apple on 11/01/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "AppDelegate.h"

#import "SINTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    self.window = [[UIWindow alloc] init];
    
    // 没有设置尺寸，会导致运行在真机时触摸事件不能传递
    self.window.frame = [UIScreen mainScreen].bounds;
    /**
      unexpected nil window in _UIApplicationHandleEventFromQueueEvent, _windowServerHitTestWindow: <UIWindow: 0x17663920; frame = (0 0; 0 0); gestureRecognizers = <NSArray: 0x176641c0>; layer = <UIWindowLayer: 0x17663b30>>
     */
    
    self.window.rootViewController = [[SINTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
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


@end
