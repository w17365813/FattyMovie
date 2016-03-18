//
//  CDHotModel.m
//  FattyMovie
//
//  Created by luo on 16/3/5.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDHotModel.h"

@implementation CDHotModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"movieID" : @[@"id",@"ID"]};
}

@end
