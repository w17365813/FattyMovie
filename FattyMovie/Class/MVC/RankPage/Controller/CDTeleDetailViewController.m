//
//  CDDetailViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDDetailViewController.h"


@interface CDDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDDetailViewController{

    UITableView *_tableView;
    NSMutableArray *_dataArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    [self loadModel];
    
    
   

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

@end
