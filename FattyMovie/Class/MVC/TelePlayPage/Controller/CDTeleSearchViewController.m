//
//  CDTeleSearchViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/9.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDTeleSearchViewController.h"
#import "CDTelePlayModel.h"
#import "CDTelePlayCell.h"
#import "CDTeleDetailViewController.h"

@interface CDTeleSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@end

@implementation CDTeleSearchViewController{

    UISearchBar *_search;
    UITableView *_tableView;

    NSMutableArray *_dataArray;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
  
    _search.delegate = self;
    
  
   
    
    
    [self.view addSubview:_tableView];
    
    [self.view addSubview:_search];

    _search.text = @"";
    [_search setPlaceholder:@"电视剧名"];
    [self loadModel:_search.text];
    
}
- (void) back{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void) loadModel:(NSString *) searchText{

    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager movieManager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:searchText forKey:@"key"];
    [manager GET:API_SEARCH  parameters:parameters progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        for (NSDictionary *dict in responseObject[@"data"]) {
            CDTelePlayModel *modle = [CDTelePlayModel yy_modelWithDictionary:dict];
           
            
            [_dataArray addObject:modle];
            
        }
        [_tableView reloadData];
        _tableView.separatorStyle = YES;
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
    }];
    
    




}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 
    [_dataArray removeAllObjects];
    [self loadModel:searchText];


}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    
        return _dataArray.count;
    
    
    
    

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;


}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    CDTelePlayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDTelePlayCell" owner:self options:nil][0];
        
    }
   
        
    
    
        CDTelePlayModel *model = _dataArray[indexPath.row];
        cell.title.text = model.title;
        [cell.img loadImageWithUrlString:model.img];
        cell.time.text = model.update_time;
        cell.status.text = model.status;
    
   
    
    
 
    
    return cell;


}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    CDTelePlayModel *model = _dataArray[indexPath.row];
    CDTeleDetailViewController *detailVC = [[CDTeleDetailViewController alloc] init];
    detailVC.film_id = model.teleID;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    



}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_search resignFirstResponder];

}

- (void) viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];


}

@end
