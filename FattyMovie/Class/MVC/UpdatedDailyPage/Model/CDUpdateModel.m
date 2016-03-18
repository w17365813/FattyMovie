//
//  CDUpdateModel.m
//  FattyMovie
//
//  Created by luo on 16/3/8.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDUpdateModel.h"

@implementation CDUpdateModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"movieID" : @[@"id",@"ID"]};
}
@end
