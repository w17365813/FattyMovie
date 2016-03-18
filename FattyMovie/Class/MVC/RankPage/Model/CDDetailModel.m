//
//  CDDetailModel.m
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDDetailModel.h"

@implementation CDDetailModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"movieID" : @[@"id",@"ID"]};
}

@end
