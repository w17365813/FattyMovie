//
//  CDMoreDetialViewController.m
//  FattyMovie


//  Created by luo on 16/3/10.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDMoreDetialViewController.h"

@interface CDMoreDetialViewController ()<UIWebViewDelegate>{
    
    
    UIWebView *_webView;
    
}

@property(nonatomic,strong)UIButton *reloadButton;
@property(nonatomic,strong)UIButton *stopButton;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *forwardButton;

@end

@implementation CDMoreDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld",API_MDBDETAIL,(unsigned long)_movieID]];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
    _webView.delegate = self;
    
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    _reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(5, self.view.frame.size.height-150, self.view.frame.size.width/4, 30)];
    [_reloadButton setTitle:@"刷新" forState:UIControlStateNormal];
    [_reloadButton setBackgroundColor:[UIColor grayColor]];
    [_reloadButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_reloadButton addTarget:self action:@selector(reloadDidPush) forControlEvents:UIControlEventTouchUpInside];
    _stopButton = [[UIButton alloc] initWithFrame:CGRectMake(5+self.view.frame.size.width/4, self.view.frame.size.height-150, self.view.frame.size.width/4, 30)];
    [_stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [_stopButton setBackgroundColor:[UIColor grayColor]];
    [_stopButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_stopButton addTarget:self action:@selector(stopDidPush) forControlEvents:UIControlEventTouchUpInside];
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(5+self.view.frame.size.width/4*2, self.view.frame.size.height-150, self.view.frame.size.width/4, 30)];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton setBackgroundColor:[UIColor grayColor]];
    [_backButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backDidPush) forControlEvents:UIControlEventTouchUpInside];
    _forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(5+self.view.frame.size.width/4*3, self.view.frame.size.height-150, self.view.frame.size.width/4, 30)];
    [_forwardButton setTitle:@"<---" forState:UIControlStateNormal];
    [_forwardButton setBackgroundColor:[UIColor grayColor]];
    [_forwardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_forwardButton addTarget:self action:@selector(forwardDidPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_reloadButton];
    [self.view bringSubviewToFront:_reloadButton];
    [self.view addSubview:_stopButton];
    [self.view bringSubviewToFront:_stopButton];
    [self.view addSubview:_backButton];
    [self.view bringSubviewToFront:_backButton];
    [self.view addSubview:_forwardButton];
    [self.view bringSubviewToFront:_forwardButton];
    
}

-(void)reloadDidPush
{
    [_webView reload];//重新读入页面
}
-(void)stopDidPush
{
    if(_webView.loading){
        [_webView stopLoading];//读入停止
    }
    
}
-(void)backDidPush
{
    if (_webView.canGoBack) {
        [_webView goBack];//返回前一画面
    }
}
-(void)forwardDidPush
{
    if (_webView.canGoForward) {
        [_webView goForward];//进入下一页面
    }
    
}

-(void)updateControlEnabled
{
    //统一更新指示按钮状态
    [UIApplication sharedApplication].networkActivityIndicatorVisible = _webView.loading;
    _stopButton.enabled = _webView.loading;
    _backButton.enabled = _webView.canGoBack;
    _forwardButton.enabled = _webView.canGoForward;
    
}
-(void)viewDidAppear:(BOOL)animated

{
    //画面显示结果后读入web页面画面
    [super viewDidAppear:animated];
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%ld",API_DBDETAIL,(unsigned long)_movieID]];
    //    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //    [_webView loadRequest:request];
    [self updateControlEnabled];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    //画面关闭时状态的活动指示器设置成off
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    // [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    [self updateControlEnabled];
    
}

- (void) webViewDidStartLoad:(UIWebView *)webView{
    
    
    [self updateControlEnabled];
    
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    
    [self updateControlEnabled];
    //NSLog(@"%@",error);
    
}


@end
