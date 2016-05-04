//
//  AppDelegate.m
//  HappyWeather
//
//  Created by 念 on 16/4/15.
//  Copyright © 2016年 小念. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "BaseNavigationViewController.h"
#import "CityListViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationServices.h>
#import "YTKNetworkConfig.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置BaseUrl
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://api.map.baidu.com";
    
    //设置定位key和搜索key，必须设置。两个必须都设置
    [AMapLocationServices sharedServices].apiKey =@"169c658660cf20d64dd3ae4f7a86735b";
    [AMapSearchServices sharedServices].apiKey = @"169c658660cf20d64dd3ae4f7a86735b";
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RootViewController *Root = [[RootViewController alloc] init];
    BaseNavigationViewController *leftNav = [[BaseNavigationViewController alloc] initWithRootViewController:Root];
    
    CityListViewController *city = [[CityListViewController alloc]init];
    BaseNavigationViewController *citynav = [[BaseNavigationViewController alloc]initWithRootViewController:city];
    
    DDMenuController *ddmu = [[DDMenuController alloc] initWithRootViewController:leftNav];
    ddmu.leftViewController = citynav;
    self.DDMenuController = ddmu;
    
    
    self.window.rootViewController = self.DDMenuController;
    [self.window makeKeyAndVisible];
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
