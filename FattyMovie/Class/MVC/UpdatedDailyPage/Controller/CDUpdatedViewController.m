//
//  CDUpdatedViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDUpdatedViewController.h"
#import "CDUpdateModel.h"
#import "CDUpdateCell.h"
#import "CDDetailViewController.h"

@interface CDUpdatedViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDUpdatedViewController{

    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSUInteger _index;

}

- (void)viewDidLoad {
    [super viewDidLoad];


    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadModel:YES];
    }];
    [header setTitle:@"松开你的爪子才能刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
    

}

- (void) back{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void) loadModel:(BOOL) refresh{

    [SVProgressHUD showWithStatus:@"正在加载..."];

    if (refresh) {
        _index = 1;
    }else{
    
        _index += 1;
    
    }
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager movieManager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(_index) forKey:@"index"];
    
    [manager GET:API_UPDATE parameters:parameters progress:^(NSProgress * downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        if (refresh) {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary *dict in responseObject[@"data"]) {
            CDUpdateModel *model = [CDUpdateModel yy_modelWithDictionary:dict];
            [_dataArray addObject:model];
            
            
        }
        [_tableView reloadData];
        [self endRefreshing];
        _tableView.separatorStyle = YES;
        if (refresh) {
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self loadModel:NO];
            }];
            footer.stateLabel.text = @"上拉或点击加载更多数据";
            footer.automaticallyRefresh = NO;
            _tableView.mj_footer = footer;
        }
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        
    } failure:^(NSURLSessionDataTask *  task, NSError * error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        _index -= 1;
        [self endRefreshing];
        NSLog(@"%@",error);
        
    }];
    


}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;

}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CDUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDUpdateCell" owner:self options:nil][0];
    }

    CDDetailModel *model = _dataArray[indexPath.row];
    [cell.img loadImageWithUrlString:model.img];
    cell.more_title.text = model.more_title;
    cell.create_time.text = model.create_time;
    
    return cell;
    


}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CDDetailViewController *detailVC = [[CDDetailViewController alloc] init];
    CDUpdateModel *model = _dataArray[indexPath.row];
    detailVC.film_id = model.movieID;
    [detailVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    


}



- (void) endRefreshing{
    
    
    if (_tableView.mj_header.isRefreshing) {
        [_tableView.mj_header endRefreshing];
        
    }
    if (_tableView.mj_footer.isRefreshing) {
        [_tableView.mj_footer endRefreshing];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{
[super viewDidDisappear:animated];
    [SVProgressHUD dismiss];

}

@end
