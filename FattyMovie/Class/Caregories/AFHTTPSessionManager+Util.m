//
//  AFHTTPSessionManager+Util.m
//  FattyMovie
//
//  Created by luo on 16/3/4.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "AFHTTPSessionManager+Util.h"

@implementation AFHTTPSessionManager (Util)

+ (instancetype) movieManager{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];

    return manager;
}

@end
