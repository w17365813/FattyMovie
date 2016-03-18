//
//  CDTelePlayModel.h
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDTelePlayModel : NSObject

@property (nonatomic, copy) NSString *rating;

@property (nonatomic, copy) NSString *update_cycle;

@property (nonatomic, assign) NSInteger teleID;

@property (nonatomic, copy) NSString *countries;

@property (nonatomic, copy) NSString *show_time;

@property (nonatomic, copy) NSString *film_type;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, assign) NSInteger sid;

@property (nonatomic, copy) NSString *casts;

@property (nonatomic, copy) NSString *subtype;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *update_time;

@end
