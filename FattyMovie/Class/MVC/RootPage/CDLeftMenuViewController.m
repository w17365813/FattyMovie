//
//  CDLeftMenuViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDLeftMenuViewController.h"
#import <RESideMenu.h>
#import "CDMainViewController.h"
#import "CDCollectViewController.h"
#import "CDUpdatedViewController.h"

@interface CDLeftMenuViewController ()

@end

@implementation CDLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];

    self.tableView.separatorStyle = NO;
    self.tableView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    if (indexPath.row == 0) {
        
    }else
    
    
    if(indexPath.row == 1){
    cell.textLabel.text = @"今日更新";
        cell.imageView.image = [UIImage originImageWithName:@"Star 2"];
    
    }else{
    
    cell.textLabel.text = @"我的收藏";
        cell.imageView.image = [UIImage originImageWithName:@"film_list_page_interested_normal"];
    
    }
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     //反选转navigation时使用
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
   
    
    CDMainViewController *mainVC = (CDMainViewController *)self.sideMenuViewController.contentViewController;
    UINavigationController *navi = (UINavigationController *)mainVC.selectedViewController;
    if (indexPath.row == 1) {
        CDUpdatedViewController *upVC = [[CDUpdatedViewController alloc] init];
        upVC.title = @"今日更新";
        [navi pushViewController:upVC animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }else if(indexPath.row == 2){
        CDCollectViewController *coVC = [[CDCollectViewController alloc] init];
        coVC.title = @"我的收藏";
        [navi pushViewController:coVC animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    
    
    
    }
    
        
    


}


@end
