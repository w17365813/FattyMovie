//
//  CDUpdateModel.h
//  FattyMovie
//
//  Created by luo on 16/3/8.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDUpdateModel : NSObject

@property (nonatomic, copy) NSString *subtype;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *directors;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *countries;

@property (nonatomic, copy) NSString *original_title;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *thunder_url;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger xin;

@property (nonatomic, assign) NSInteger movieID;

@property (nonatomic, copy) NSString *aka;

@property (nonatomic, copy) NSString *prevue_url;

@property (nonatomic, copy) NSString *more_title;

@property (nonatomic, copy) NSString *casts;

@property (nonatomic, copy) NSString *genres;

@property (nonatomic, assign) NSInteger reying;

@property (nonatomic, assign) NSInteger rating;

@property (nonatomic, assign) NSInteger douban_id;

@end
