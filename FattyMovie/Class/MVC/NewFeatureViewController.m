//
//  NewFeatureViewController.m
//  CD1507WB
//
//  Created by luo on 16/2/26.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "NewFeatureViewController.h"
#import <RESideMenu.h>
#import "AppDelegate.h"
#import "CDMainViewController.h"
#import "CDLeftMenuViewController.h"

@interface NewFeatureViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation NewFeatureViewController

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self generateNewFeaturePages];
    
    // Do any additional setup after loading the view.
}

- (void)generateNewFeaturePages
{
  
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(w * 5, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    for (int i = 1; i < 6; i++) {
        NSString *imgName = [NSString stringWithFormat:@"%02d.jpg",i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(w * (i -1), 0, w, h)];
        imageView.image = [UIImage imageNamed:imgName];
        [self.scrollView addSubview:imageView];
        
        if (i == 5) {
            imageView.userInteractionEnabled = YES;
            UIButton *getinBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [getinBtn setTitle:@"进入" forState:UIControlStateNormal];
            [getinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [getinBtn setBackgroundColor:[UIColor redColor]];
            getinBtn.layer.cornerRadius = 5;
            getinBtn.layer.masksToBounds = YES;
            getinBtn.frame = CGRectMake(0, 0, 250, 50);
            getinBtn.center = CGPointMake(CGRectGetWidth(imageView.frame) * 0.5, CGRectGetHeight(imageView.frame) - 200);
            [imageView addSubview:getinBtn];
            [getinBtn addTarget:self action:@selector(getin) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

/** 进入主程序页面*/
- (void)getin
{
    
    // 截屏
    UIView *view = [self.view snapshotViewAfterScreenUpdates:YES];
    
    CDMainViewController *mainVC = [[CDMainViewController alloc] init];
    CDLeftMenuViewController *leftVC = [[CDLeftMenuViewController alloc] init];
    RESideMenu *rootVC = [[RESideMenu alloc] initWithContentViewController:mainVC leftMenuViewController:leftVC rightMenuViewController:nil];
    
    
    
    
    
    rootVC.scaleMenuView = NO;
    rootVC.scaleContentView = NO;
    rootVC.contentViewShadowEnabled = NO;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = rootVC;
    
    [UIView animateWithDuration:1 animations:^{
        view.transform = CGAffineTransformMakeScale(2.0, 2.0);
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
    
    
   
    
 
}



@end
