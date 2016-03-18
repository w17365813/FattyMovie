//
//  CDDatabaseManager.h
//  FattyMovie
//
//  Created by luo on 16/3/14.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDDetailModel.h"
#import "CDDBModel.h"


@interface CDDatabaseManager : NSObject

// 单例
+ (CDDatabaseManager *)sharedManager;

// 插入数据
- (BOOL)insertCollectionTableModel:(CDDBModel *) model;

// 判断数据库中是否存在对应数据
- (BOOL)isExistsWithAppId:(NSInteger) movieID;

// 获取所有的收藏数据
- (NSArray *)getAllCollection;

// 删除收藏数据
- (BOOL)deleteColletionTableModel:(CDDBModel *) model;


@end
