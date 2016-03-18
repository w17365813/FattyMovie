//
//  CDHotViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/5.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDHotViewController.h"
#import "CDHotModel.h"
#import "CDCollectionViewCell.h"

@interface CDHotViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation CDHotViewController{

    UICollectionView *_collectView;
    NSMutableArray *_dataArray;
    NSUInteger _index;


}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 50;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 90);
    CGFloat h = 1.6*w;
    layout.itemSize = CGSizeMake(w, h);
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    _collectView.backgroundColor = [UIColor whiteColor];
    
    _collectView.delegate = self;
    _collectView.dataSource = self;
    
    [_collectView registerNib:[UINib nibWithNibName:@"CDCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
  [self.view addSubview:_collectView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataModel:YES];
    }];
    [header setTitle:@"松开你的爪子才能刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
    _collectView.mj_header = header;
    [_collectView.mj_header beginRefreshing];
}

- (void) loadDataModel:(BOOL) refresh{

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
    
    [manager GET:API_HOT parameters:parameters progress:^(NSProgress *  downloadProgress) {
    
    } success:^(NSURLSessionDataTask *  task, id  responseObject) {
        if (refresh) {
            [_dataArray removeAllObjects];
        }
        
        for (NSDictionary *dict in responseObject[@"data"]) {
            CDHotModel *model = [CDHotModel yy_modelWithDictionary:dict];
            [_dataArray addObject:model];
        }
        [_collectView reloadData];
        [self endRefreshing];
        if (refresh) {
            
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self loadDataModel:NO];
            }];
            footer.stateLabel.text = @"上拉或点击加载更多数据";
            footer.automaticallyRefresh = NO;
            _collectView.mj_footer = footer;
        }
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        _index -= 1;
        [self endRefreshing];
        NSLog(@"%@",error);
    }];
    
    


}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _dataArray.count;

}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    CDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
 

    
    CDHotModel *model = _dataArray[indexPath.row];
    [cell.img loadImageWithUrlString:model.img];
    cell.titleLabel.text = model.title;
    
    return cell;
    



}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    CDDetailViewController *detailVC = [[CDDetailViewController alloc] init];
    CDHotModel *model = _dataArray[indexPath.row];
    detailVC.film_id = model.movieID;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    


}

- (void) endRefreshing{
    
    
    if (_collectView.mj_header.isRefreshing) {
        [_collectView.mj_header endRefreshing];
        
    }
    if (_collectView.mj_footer.isRefreshing) {
        [_collectView.mj_footer endRefreshing];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];


}

@end
