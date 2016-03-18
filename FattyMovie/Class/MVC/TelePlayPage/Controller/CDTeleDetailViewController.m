//
//  CDTeleDetailViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/8.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDTeleDetailViewController.h"
#import "CDTeleDetailCell.h"
#import "CDTelePlayModel.h"
@interface CDTeleDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CDTeleDetailViewController{

    UITableView *_tableView;
    NSMutableArray *_dataArray;


}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.view addSubview:_tableView];
    [self loadModel];

}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];


}

- (void) loadModel{

    [SVProgressHUD showWithStatus:@"正在加载"];
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@(_film_id) forKey:@"film_id"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager movieManager];
    [manager GET:API_TELEDETAIL parameters:parameters progress:^(NSProgress *  downloadProgress) {
        
    } success:^(NSURLSessionDataTask *  task, id   responseObject) {
        CDTelePlayModel *model = [CDTelePlayModel yy_modelWithDictionary:responseObject[@"data"]];
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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CDTeleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CDTeleDetailCell" owner:self options:nil][0];
    }

    CDTelePlayModel *model = _dataArray[indexPath.row];
    
    cell.title.text = model.title;
    [cell.img loadImageWithUrlString:model.img];
    cell.film_type.text = model.film_type;
    cell.show_time.text = model.show_time;
    cell.countries.text = model.countries;
    cell.status.text = model.status;
    cell.update_time.text = model.update_time;
    cell.update_cycle.text = model.update_cycle;
    cell.casts.text = model.casts;
    cell.summary.text = model.summary;
    
    return cell;
    



}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    

}

@end
