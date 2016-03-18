//
//  CDDeveloperViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/12.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDDeveloperViewController.h"
#import "ZYAnimationLayer.h"
#import "FadeStringView.h"

@interface CDDeveloperViewController ()

@end

@implementation CDDeveloperViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
   
    
    [ZYAnimationLayer createAnimationLayerWithString:@"By LUO Pang Pang" andRect:CGRectMake(0, self.view.bounds.size.height/5, self.view.frame.size.width, 300) andView:self.view andFont:[UIFont systemFontOfSize:40] andStrokeColor:[UIColor redColor]];
    
    FadeStringView *fadeStringView = [[FadeStringView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/5, 200, 40)];
    fadeStringView.text = @"开发者:";
    fadeStringView.foreColor = [UIColor whiteColor];
    fadeStringView.backColor = [UIColor redColor];
    fadeStringView.font = [UIFont systemFontOfSize:30];
    fadeStringView.alignment = NSTextAlignmentLeft;
    [self.view addSubview:fadeStringView];
    [fadeStringView fadeRightWithDuration:2];
    

}

@end
