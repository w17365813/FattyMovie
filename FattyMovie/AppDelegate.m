//
//  AppDelegate.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "AppDelegate.h"
#import "NewFeatureViewController.h"

#import <RESideMenu.h>
#import "MBProgressHUDManager.h"
#import "CDMainViewController.h"
#import "CDLeftMenuViewController.h"
#import <BmobSDK/Bmob.h>
#import <UMSocial.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMSocialData setAppKey:@"56e3795067e58e81b60019bf"];
    [Bmob registerWithAppKey:@"faad8140fe0b98147c9c56cf81695e86"];
    
    

    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    // 获取当前程序版本号
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    
    NSString *currentVersion = dict[@"CFBundleShortVersionString"];
    
    // 跟上次存下来的版本号对比
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefault objectForKey:@"LastVersion"];
    
    // 如果是升序
    if ([lastVersion compare:currentVersion] == NSOrderedAscending || lastVersion == nil) {
        
        NewFeatureViewController *newFeature = [NewFeatureViewController new];
        self.window.rootViewController = newFeature;
        
        [userDefault setObject:currentVersion forKey:@"LastVersion"];
        [userDefault synchronize];
    }else {
        
        CDMainViewController *mainVC = [[CDMainViewController alloc] init];
        CDLeftMenuViewController *leftVC = [[CDLeftMenuViewController alloc] init];
        RESideMenu *rootVC = [[RESideMenu alloc] initWithContentViewController:mainVC leftMenuViewController:leftVC rightMenuViewController:nil];
        
        
        
        
        
        rootVC.scaleMenuView = NO;
        rootVC.scaleContentView = NO;
        rootVC.contentViewShadowEnabled = NO;
        
        self.window.rootViewController = rootVC;
        
    }
    
  
    [self monitoerNetwork];
    
    
    // Override point for customization after application launch.
    return YES;
}



- (void) monitoerNetwork{

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *str = nil;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                str = @"Wifi";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                str = @"蜂窝";
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                str = @"无法连接";
                break;
            case AFNetworkReachabilityStatusUnknown:
                str = @"未知";
                break;
            default:
                break;
        }
        
        MBProgressHUDManager *mgr =  [[MBProgressHUDManager alloc] initWithView:self.window];
        
        
        
        
        [mgr showNoticeMessage:[NSString stringWithFormat:@"当前网络:%@",str] duration:2 complection:^{
            
        }];
        
    }];


    [manager startMonitoring];
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
