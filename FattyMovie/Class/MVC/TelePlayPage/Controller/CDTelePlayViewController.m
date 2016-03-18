//
//  CDTelePlayViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/3.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDTelePlayViewController.h"
#import "CDHeaderView.h"
#import "CDHeaderCollectionViewCell.h"
#import "CDTeleDetailViewController.h"
#import "CDTeleSearchViewController.h"


@interface CDTelePlayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,CDHeaderViewDelegate,CDHeaderCollectionViewCellDelegate>

@property(nonatomic, weak)UICollectionView *collectionView;
@property(nonatomic, weak)CDHeaderView *headerView;


@end

@implementation CDTelePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatUI];
    CDHeaderView * headerView = [CDHeaderView creatHeaderView];
    [self.view addSubview:headerView];
    headerView.headerArray = @[@"最新",@"大陆",@"美剧",@"香港",@"韩国",@"台湾",@"日本",@"其它"];
    self.headerView = headerView;
    self.headerView.delegates = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(toSearch)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}


- (void) toSearch{

    CDTeleSearchViewController *searchVC = [[CDTeleSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
    


}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = scrollView.contentOffset.x/self.view.frame.size.width;
    [self.headerView setSelectedIndexAnimated:page];
    
}


- (void)headerView:(CDHeaderView *)header selectedIndexChanged:(NSUInteger)index{
    
    [self.collectionView scrollRectToVisible:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
    
}

- (void)creatUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //item行间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //设置统一大小的item
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//边距屏幕宽
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    collectionView.pagingEnabled = YES;
    
    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[CDHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.headerView.headerArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CDHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.countries = self.headerView.headerArray[indexPath.row];
   
    return cell;
}

- (void) pushToDetail:(NSUInteger)film_id{

    CDTeleDetailViewController *detailVC = [[CDTeleDetailViewController alloc] init];
    detailVC.film_id = film_id;
    [self.navigationController pushViewController:detailVC animated:YES];



}

- (void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];

}

@end
