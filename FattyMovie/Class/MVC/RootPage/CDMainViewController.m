//
//  CDMainViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDMainViewController.h"
#import "CDRankViewController.h"
#import "CDHotViewController.h"
#import "CDTelePlayViewController.h"
#import "CDSettingViewController.h"
#import <RESideMenu.h>

@interface CDMainViewController ()

@end

@implementation CDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   [self setTabBarViewControllers];

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) setTabBarViewControllers{

    NSArray *vcTitleArr = @[@"排行榜",@"热映大片",@"电视剧",@"设置"];
    NSArray *vcNameArr = @[@"CDRankViewController",@"CDHotViewController",@"CDTelePlayViewController",@"CDSettingViewController"];
    NSArray *norImgNameArr = @[@"label_bar_film_critic_normal",@"label_bar_movie_normal",@"label_bar_film_list_normal",@"label_bar_my_normal"];
    NSArray *selectedImgNameArr = @[@"label_bar_film_critic_selected",@"label_bar_movie_selected",@"label_bar_film_list_selected",@"label_bar_my_selected"];
    
    for (NSString *vcName in vcNameArr) {
        Class vcClass = NSClassFromString(vcName);
        UIViewController *vc = [[vcClass alloc] init];
        NSInteger index = [vcNameArr indexOfObject:vcName];
        
        vc.title = vcTitleArr[index];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        [vc.tabBarItem setImage:[UIImage originImageWithName:norImgNameArr[index]]];
        [vc.tabBarItem setSelectedImage:[UIImage originImageWithName:selectedImgNameArr[index]]];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        
        vc.tabBarController.tabBar.translucent = NO;
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.navigationController.navigationBar.translucent = NO;
        [vc.navigationController.navigationBar setBackgroundImage:[UIImage originImageWithName:@"weibo_movic_navigation_bg"] forBarMetrics:UIBarMetricsDefault];
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(showLeftMenuAction)];
        [vc.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
        [vc.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        
        [self addChildViewController:navi];
        
        
        
    }
    




}

- (void) showLeftMenuAction{
    
    
    [self.sideMenuViewController presentLeftMenuViewController];
    
}


@end
