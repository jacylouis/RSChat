//
//  AppDelegate.m
//  RSChat
//
//  Created by hehai on 11/10/15.
//  Copyright (c) 2015 hehai. All rights reserved.
//

#import "AppDelegate.h"
#import "RSHomeViewController.h"
#import "RSContactsViewController.h"
#import "RSDiscoverViewController.h"
#import "RSMeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setContentVC];
// 1 远程推送
// 1.1 注册通知
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] <= 8.0) {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    
    // 测试:可以使 每次重新启动app（先从后台关掉），就让badgeNum减一
    NSInteger badgeNum = application.applicationIconBadgeNumber;
    badgeNum--;
    if (badgeNum > 0) {
        [application setApplicationIconBadgeNumber:0];
        [application setApplicationIconBadgeNumber:badgeNum];
    }
    
    return YES;
}

// 1.2 获取到用户同意时，则接收从服务器端返回的 DeviceToken

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken:%@",deviceToken);
}
// 1.3 点击通知后的动作
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"userInfo:%@",userInfo);
    
    NSInteger badgeNum = application.applicationIconBadgeNumber;
    badgeNum--;
    if (badgeNum > 0) {
        [application setApplicationIconBadgeNumber:0];
        [application setApplicationIconBadgeNumber:badgeNum];
    }
}

- (void)setContentVC {
    // 设置导航栏文字、左右按钮颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 设置 tabbarItem 的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0x09/255.0 green:0xbb/255.0 blue:0x07/255.0 alpha:1.0]} forState:UIControlStateSelected];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    RSHomeViewController *homeController = [[RSHomeViewController alloc] init];
    RSContactsViewController *contactsController = [[RSContactsViewController alloc] init];
    RSDiscoverViewController *discoverController = [[RSDiscoverViewController alloc] init];
    RSMeViewController *meController = [[RSMeViewController alloc] init];
    
    UINavigationController *homeNavi = [[UINavigationController alloc] initWithRootViewController:homeController];
    UINavigationController *contactsNavi = [[UINavigationController alloc] initWithRootViewController:contactsController];
    UINavigationController *discoverNavi = [[UINavigationController alloc] initWithRootViewController:discoverController];
    UINavigationController *meNavi = [[UINavigationController alloc] initWithRootViewController:meController];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"微信" image:[UIImage imageNamed:@"tabbar_mainframe"] tag:0];

    // 选中时为图片本身颜色 : UIImageRenderingModeAlwaysOriginal
    homeItem.selectedImage = [[UIImage imageNamed:@"tabbar_mainframeHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *contactsItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:[UIImage imageNamed:@"tabbar_contacts"] tag:1];
    contactsItem.selectedImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *discoverItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] tag:2];
    discoverItem.selectedImage = [[UIImage imageNamed:@"tabbar_discoverHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *meItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_me"] tag:3];
    meItem.selectedImage = [[UIImage imageNamed:@"tabbar_meHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    homeNavi.tabBarItem = homeItem;
    contactsNavi.tabBarItem = contactsItem;
    discoverNavi.tabBarItem = discoverItem;
    meNavi.tabBarItem = meItem;

    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    [tabbarController setViewControllers:@[homeNavi, contactsNavi, discoverNavi, meNavi]];
    
    [tabbarController setSelectedIndex:0];
    
    NSInteger badgeNum0 = 32;
    UITabBarItem * item=[tabbarController.tabBar.items objectAtIndex:0];
    item.badgeValue=[NSString stringWithFormat:@"%ld",badgeNum0];
    
    self.window.rootViewController = tabbarController;
    
    [self.window makeKeyAndVisible];
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