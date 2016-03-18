//
//  CDDatabaseManager.m
//  FattyMovie
//
//  Created by luo on 16/3/14.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDDatabaseManager.h"
#import <FMDB.h>

@implementation CDDatabaseManager

{
    FMDatabase * _db;
}

+ (CDDatabaseManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static CDDatabaseManager * globalManager = nil;
    dispatch_once(&onceToken, ^{
        if (!globalManager) {
            globalManager = [[CDDatabaseManager alloc] init];
        }
    });
    return globalManager;
}

// 重写初始化方法
- (instancetype)init
{
    if (self = [super init]) {
        [self initDB];
    }
    return self;
}

// 初始化数据库
- (void)initDB
{
    if (!_db) {
        // 将数据库文件放入沙盒路径下的Documents中
        NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/fattyMovie.db"];
        NSLog(@"datapath = %@", dbPath);
        // 创建数据库管理对象
        _db = [[FMDatabase alloc] initWithPath:dbPath];
    }
    // 打开数据库
    if ([_db open]) {
        // 创建数据库表
        [_db executeUpdate:@"create TABLE if not exists collection (movieID int primary key, title text, img text);"];
       
    }
    else {
        NSLog(@"打开数据失败");
    }
}

- (BOOL)isExistsWithAppId:(NSInteger )movieID
{
    // 从数据库查询对应movieID的数据
    
    FMResultSet * rs = [_db executeQuery:@"select * from collection where movieID=?",@(movieID)];
    // 判断查询的数据是否存在
    if ([rs next]) {
        return YES;
    }
    else {
        return NO;
    }
}

// 插入数据
- (BOOL)insertCollectionTableModel:(CDDBModel *)model
{
    int movieID = model.movieID;
    
    // 判断是否已有数据
    if ([self isExistsWithAppId:movieID]) {
        // 更新已存在的数据
        // SQL是不区分大小写的
        BOOL isSuccess = [_db executeUpdate:@"update collection SET title=?, img=? where movieID=?", model.title, model.img, @(model.movieID)];
        return isSuccess;
    }
    else {
        BOOL isSuccess = [_db executeUpdate:@"insert into collection values(?, ?, ?)", @(model.movieID), model.title, model.img];
        return isSuccess;
    }
}

- (NSArray *)getAllCollection
{
    NSMutableArray * colletionModels = [NSMutableArray array];
    // 获取collection表中所有数据
    FMResultSet * rs = [_db executeQuery:@"select * from collection"];
    // 遍历结果集
    while ([rs next]) {
        // 创建模型数据
        CDDBModel * model = [[CDDBModel alloc] init];
        
        model.movieID = [rs intForColumn:@"movieID"];
        model.title = [rs stringForColumn:@"title"];
        model.img = [rs stringForColumn:@"img"];
        [colletionModels addObject:model];
    }
    return [colletionModels copy];
}


- (BOOL)deleteColletionTableModel:(CDDBModel *)model
{
    if ([self isExistsWithAppId:model.movieID]) {
        BOOL isSuccess = [_db executeUpdate:@"DELETE FROM collection where movieID=?", @(model.movieID)];
        return isSuccess;
    }
    else {
        return NO;
    }
}

@end
