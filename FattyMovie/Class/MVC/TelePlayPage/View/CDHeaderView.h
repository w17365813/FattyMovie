//
//  CDHeaderView.h
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDHeaderView;
@class CDHeaderCollectionViewCell;
@protocol CDHeaderViewDelegate <NSObject>

- (void) headerView:(CDHeaderView *)header selectedIndexChanged:(NSUInteger) index;

@end

@interface CDHeaderView : UIScrollView

@property (nonatomic, weak) NSArray *sectionArray;
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, weak) id <CDHeaderViewDelegate> delegates;
@property (nonatomic, strong) NSArray *headerArray;

+ (CDHeaderView *) creatHeaderView;
- (void) setSelectedIndexAnimated:(NSUInteger)selectedIndex;

@end
