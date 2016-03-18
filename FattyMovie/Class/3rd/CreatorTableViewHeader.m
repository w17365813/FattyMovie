//
//  CreatorTableViewHeader.m
//  MovieFans
//
//  Created by 钟义 on 16/1/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import "CreatorTableViewHeader.h"

@implementation CreatorTableViewHeader
{
    CGRect  initFrame;
    CGFloat defaultViewHeight;
    CGRect   subViewsFrame;
}

-(void)layoutWithTableView:(UITableView*)tableView andBackGroundView:(UIView*)view andIconImageView:(UIImageView *)iconImageView{
    
    _tableView=tableView;
    _bigImageView=view;
    _iconImageView=iconImageView;
    initFrame=_bigImageView.frame;
    defaultViewHeight  = initFrame.size.height;
    subViewsFrame=_iconImageView.frame;
    
    //_playButton.layer.cornerRadius=_playButton.frame.size.width/2;
    UIView* heardView=[[UIView alloc]initWithFrame:initFrame];
    self.tableView.tableHeaderView=heardView;
    [_tableView addSubview:_bigImageView];
    [_tableView addSubview:_iconImageView];

    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect f     = _bigImageView.frame;
    f.size.width = _tableView.frame.size.width;
    _bigImageView.frame  = f;
    
    if (scrollView.contentOffset.y<0) {
        CGFloat offset = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        
        initFrame.origin.x= - offset /2;
        initFrame.origin.y= - offset;
        initFrame.size.width=_tableView.frame.size.width+offset;
        initFrame.size.height=defaultViewHeight+offset;
        _bigImageView.frame=initFrame;
        
        [self viewDidLayoutSubviews:offset/2];
        
        
    }
    
    
}
- (void)viewDidLayoutSubviews:(CGFloat)offset
{
    _iconImageView.frame=CGRectMake(0, 0, 80+offset, 80+offset);
    _iconImageView.center=CGPointMake(_bigImageView.center.x, _bigImageView.center.y);
    _iconImageView.layer.cornerRadius=_iconImageView.frame.size.width/2;
    
    
}
- (void)resizeView
{
    initFrame.size.width = _tableView.frame.size.width;
    _bigImageView.frame = initFrame;
    
}

@end
