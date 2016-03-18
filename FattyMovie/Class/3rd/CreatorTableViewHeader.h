//
//  CreatorTableViewHeader.h
//  MovieFans
//
//  Created by 钟义 on 16/1/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatorTableViewHeader : NSObject

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UIView* bigImageView;
@property(nonatomic,strong)UIImageView* iconImageView;

-(void)layoutWithTableView:(UITableView*)tableView andBackGroundView:(UIView*)view andIconImageView:(UIImageView *)iconImageView;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

- (void)resizeView;

@end
