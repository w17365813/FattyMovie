//
//  CDDetailViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDDetailViewController.h"
#import "CDMovieDetailViewController.h"
#import "CDMoreDetialViewController.h"
#import <UMSocial.h>
#import "CDDatabaseManager.h"
#import "CollectionCell.h"
#import "CDDBModel.h"

@interface CDDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDDetailViewController{

    UITableView *_tableView;
    NSMutableArray *_dataArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我" style:UIBarButtonItemStylePlain target:self action:@selector(toDetail)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor redColor]];
    [self.view addSubview:_tableView];
    
    [self loadModel];
    
    
   

}
- (void) back{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void) toDetail{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    UIAlertAction *detail = [UIAlertAction actionWithTitle:@"详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
       
        CDMovieDetailViewController *mDetail = [[CDMovieDetailViewController alloc] init];
        CDDetailModel *model = _dataArray.firstObject;
        mDetail.movieID = model.douban_id;
        [mDetail setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:mDetail animated:YES];
        
    }];

    UIAlertAction *comments = [UIAlertAction actionWithTitle:@"详情手机版" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        CDMoreDetialViewController *mDetail = [[CDMoreDetialViewController alloc] init];
        CDDetailModel *model = _dataArray.firstObject;
        mDetail.movieID = model.douban_id;
        [mDetail setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:mDetail animated:YES];
        
        
        
        
    }];
    UIAlertAction *share = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        CDDetailModel *model = _dataArray.firstObject;
        [UMSocialSnsService presentSnsIconSheetView:self appKey:nil shareText:model.title shareImage:[UIImage originImageWithName:model.img] shareToSnsNames:[NSArray arrayWithObjects:
            UMShareToSina,
            UMShareToTencent,
            UMShareToQzone,
            UMShareToQQ,
            UMShareToRenren,
            UMShareToDouban,
            UMShareToEmail,
            UMShareToSms,
            UMShareToFacebook,
            UMShareToTwitter,nil] delegate:nil];
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *collect = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        
       
        
        
        
        
        CDDetailModel *model = _dataArray.firstObject;
        
        CDDBModel *model1 = [[CDDBModel alloc] init];
        model1.movieID = model.movieID;
        model1.title = model.title;
        model1.img = model.img;
        
        
        BOOL isSuccess = [[CDDatabaseManager sharedManager] insertCollectionTableModel:model1];
        if (isSuccess) {
            collect.enabled = NO;
            
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        }else{
        
        
            [SVProgressHUD showErrorWithStatus:@"收藏失败"];
        
        
        }
        
        
        
        
        
        
    }];
    
    
    
    [alert addAction:detail];
    [alert addAction:comments];
    [alert addAction:share];
    [alert addAction:collect];
    [alert addAction:cancel];
}

- (void) loadModel{
    [SVProgressHUD showWithStatus:@"正在加载"];

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(_film_id) forKey:@"film_id"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager movieManager];
    [manager GET:API_MDETAIL parameters:parameters progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
            CDDetailModel *model = [CDDetailModel yy_modelWithDictionary:responseObject[@"data"]];
            [_dataArray addObject:model];
        
        [_tableView reloadData];
        _tableView.separatorStyle = YES;
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
      
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        NSLog(@"%@",error);
        
    }];
    
    

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 800;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CDDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDDetailCell" owner:self options:nil][0];
    }
    CDDetailModel *model = _dataArray[indexPath.row];
    
    cell.title.text = model.title;
    [cell.img loadImageWithUrlString:model.img];
    cell.genres.text = model.genres;
    cell.year.text = [NSString stringWithFormat:@"%ld年",(long)model.year];
    cell.rating.text = [NSString stringWithFormat:@"%ld分",(long)model.rating];
    cell.countries.text = model.countries;
    cell.directors.text = model.directors;
    cell.casts.text = model.casts;
    cell.summary.text = model.summary;
    
    return cell;
    



}

- (void) viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    [SVProgressHUD dismiss];

}

@end
