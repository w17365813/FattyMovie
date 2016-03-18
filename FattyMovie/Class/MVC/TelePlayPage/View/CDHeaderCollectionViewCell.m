//
//  CDHeaderCollectionViewCell.m
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDHeaderCollectionViewCell.h"
#import "CDTelePlayModel.h"
#import "CDTelePlayCell.h"
#import "CDTeleDetailViewController.h"

@interface CDHeaderCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation CDHeaderCollectionViewCell{

    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSUInteger _index;

}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
        
    }
    return self;


}

- (void) createUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, 44, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    [self.contentView addSubview:_tableView];
    

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadModel:YES];
    }];
    [header setTitle:@"放开你的爪爪刷新数据" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
    _tableView.mj_header = header;

}

- (void) loadModel:(BOOL) refresh{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    if (refresh) {
        _index = 1;
        
    }else{
    
        _index += 1;
    
    
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager movieManager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *str = @"电视剧";

    
    
    [parameters setObject: _countries forKey:@"countries"];
    
    
    [parameters setObject:@(_index) forKey:@"index"];
    
    [parameters setObject:str forKey:@"subtype"];
    
    [manager GET:API_TELEPLAY parameters:parameters progress:^(NSProgress *  downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        if (refresh) {
            [_dataArray removeAllObjects];
        }
        for (NSDictionary *dict in responseObject[@"data"]) {
            CDTelePlayModel *model = [CDTelePlayModel yy_modelWithDictionary:dict];
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

- (void)setCountries:(NSString *)countries
{
    _countries = countries;
    [_tableView.mj_header beginRefreshing];

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dataArray.count;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CDTelePlayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDTelePlayCell" owner:self options:nil][0];
    }
    CDTelePlayModel *model = _dataArray[indexPath.row];
    
    cell.title.text = model.title;
    cell.time.text = model.update_time;
    cell.status.text = [NSString stringWithFormat:@"[%@]",model.status];
    [cell.img loadImageWithUrlString:model.img];
    
    

    return cell;


}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    CDTelePlayModel *model = _dataArray[indexPath.row];
    [self.delegate pushToDetail:model.teleID];



}


- (void) endRefreshing{
    
    
    if (_tableView.mj_header.isRefreshing) {
        [_tableView.mj_header endRefreshing];
        
    }
    if (_tableView.mj_footer.isRefreshing) {
        [_tableView.mj_footer endRefreshing];
    }
    
}

@end
