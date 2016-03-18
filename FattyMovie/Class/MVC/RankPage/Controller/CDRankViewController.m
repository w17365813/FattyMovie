//
//  CDRankViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDRankViewController.h"
#import "CDTRankCell.h"
#import "CDRankModel.h"



@interface CDRankViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDRankViewController{
    
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSUInteger _index;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    
    [self.view addSubview:_tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadModel:YES];
    }];
    [header setTitle:@"放开你的爪爪刷新数据" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;
    [_tableView.mj_header beginRefreshing];
    

}

- (void) loadModel:(BOOL) refresh
{
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
    
    
     [manager GET:API_RANK parameters:parameters progress:^(NSProgress *  downloadProgress) {
         
     } success:^(NSURLSessionDataTask *  task, id   responseObject) {
         if (refresh) {
             [_dataArray removeAllObjects];
         }
         for (NSDictionary *dict in responseObject[@"data"]) {
             CDRankModel *model = [CDRankModel yy_modelWithDictionary:dict];
             [_dataArray addObject:model];
         }
         [_tableView reloadData];
         [self endRefreshing];
         _tableView.separatorStyle = YES;
         if (refresh) {
             _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
             MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                 [self loadModel:NO];
             }];
             footer.stateLabel.text = @"上拉或点击加载更多数据";
             footer.automaticallyRefresh = NO;
             _tableView.mj_footer = footer;
         }
         [SVProgressHUD showSuccessWithStatus:@"加载成功"];
         
     } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
     
         [SVProgressHUD showErrorWithStatus:@"加载失败"];
         _index -= 1;
         [self endRefreshing];
         NSLog(@"%@",error);
            }];
    
    



}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;



}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CDTRankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDTRankCell" owner:self options:nil][0];
    }
    
    CDRankModel *model = _dataArray[indexPath.row];
    
    cell.titleLabel.text = model.title;
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",(long)model.rank];
    
    [cell.movieImage loadImageWithUrlString:model.img];
    cell.genresLabel.text = model.genres;
    cell.ratingLabel.text = [NSString stringWithFormat:@"%ld",(long)model.rating];
    return cell;
    


}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 100;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CDDetailViewController *detailVC = [[CDDetailViewController alloc] init];
    CDRankModel *model = _dataArray[indexPath.row];
    
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
- (void) viewDidAppear:(BOOL)animated{


    [super viewDidAppear:animated];
    [SVProgressHUD dismiss];


}
@end
