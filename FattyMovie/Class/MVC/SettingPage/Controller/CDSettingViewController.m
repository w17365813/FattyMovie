//
//  CDSettingViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDSettingViewController.h"
#import "ZHBlurtView.h"
#import "CDDeveloperViewController.h"
#import <SDImageCache.h>
#import "CDLoginViewController.h"
#import "CDUserInfoViewController.h"
#import "CDOpinionViewController.h"


@interface CDSettingViewController ()<UITableViewDataSource,UITableViewDelegate,ZHBlurtViewDelegate>

@end

@implementation CDSettingViewController{

    UITableView *_tableView;
    NSArray *_dataArray;
    ZHBlurtView *_view;


}




- (void)viewDidLoad {
    [super viewDidLoad];
    _view = [[ZHBlurtView alloc] initWithFrame:self.view.frame WithHeaderImgHeight:200 iconHeight:100];
   
    
    _view.delegate = self;
    [self.view addSubview:_view];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _view.headerImgHeight, self.view.frame.size.width, self.view.frame.size.height - _view.headerImgHeight-108) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];

    
    
}

- (void) login{

    if ([BmobUser getCurrentUser]) {
        
        CDUserInfoViewController *userInfoVC = [[CDUserInfoViewController alloc] init];
        [self.navigationController pushViewController:userInfoVC animated:YES];
        
        
    }else{
    
    
    CDLoginViewController *userVC = [[CDLoginViewController alloc] init];
        
        [userVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:userVC animated:YES];
        
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }

    _dataArray = @[@"开发者信息",@"清空缓存",@"意见反馈",@"给我评分",@"版本信息"];
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    if (indexPath.row == 4) {
        cell.detailTextLabel.text = @"1.0.0";
    }
    
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
     
        CDDeveloperViewController *dVC = [[CDDeveloperViewController alloc] init];
        [self.navigationController pushViewController:dVC animated:YES];
        
    }
    if (indexPath.row == 1) {
        
        NSUInteger diskCount = [SDImageCache sharedImageCache].getDiskCount;
        NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
        NSString *msg = [NSString stringWithFormat:@"缓存文件数量:%lu,缓存文件大小:%.2fM",(unsigned long)diskCount,cacheSize/1024.0/1024.0];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:msg preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * clear = [UIAlertAction actionWithTitle:@"清除缓存" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
            [[SDImageCache sharedImageCache] clearMemory];
            [[SDImageCache sharedImageCache] clearDisk];
            UIAlertController * alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"清除成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert1 addAction:cancel1];
            [self presentViewController:alert1 animated:YES completion:nil];
        }];
        
        [alert addAction:clear];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    if (indexPath.row == 2) {
        CDOpinionViewController *oVC = [[CDOpinionViewController alloc] init];
        [self.navigationController pushViewController:oVC animated:YES];
    }
    

    if (indexPath.row == 3) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择分数" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *one = [UIAlertAction actionWithTitle:@"1分" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您的评价!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert1 addAction:cancel];
            [self presentViewController:alert1 animated:YES completion:nil];
        }];
        
        UIAlertAction *two = [UIAlertAction actionWithTitle:@"2分" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您的评价!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert1 addAction:cancel];
            [self presentViewController:alert1 animated:YES completion:nil];
        }];
        UIAlertAction *three = [UIAlertAction actionWithTitle:@"3分" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您的评价!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert1 addAction:cancel];
            [self presentViewController:alert1 animated:YES completion:nil];
        }];
        UIAlertAction *four = [UIAlertAction actionWithTitle:@"4分" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您的评价!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert1 addAction:cancel];
            [self presentViewController:alert1 animated:YES completion:nil];
        }];
        UIAlertAction *five = [UIAlertAction actionWithTitle:@"5分" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您的评价!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert1 addAction:cancel];
            [self presentViewController:alert1 animated:YES completion:nil];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:one];
        [alert addAction:two];
        [alert addAction:three];
        [alert addAction:four];
        [alert addAction:five];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

}


@end
