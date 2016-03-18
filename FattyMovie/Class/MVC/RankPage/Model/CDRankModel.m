//
//  CDRankModel.m
//  FattyMovie
//
//  Created by luo on 16/3/5.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDRankModel.h"

@implementation CDRankModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"movieID" : @[@"id",@"ID"]};
}

@end
