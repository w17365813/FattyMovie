//
//  UIImageView+Util.m
//  FattyMovie
//
//  Created by luo on 16/3/5.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "UIImageView+Util.h"

@implementation UIImageView (Util)

- (void)loadImageWithUrlString:(NSString *)urlStr{

    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"movie_default_light_300x450"]];

}

@end
