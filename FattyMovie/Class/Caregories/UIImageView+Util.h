//
//  UIImageView+Util.h
//  FattyMovie
//
//  Created by luo on 16/3/5.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)
/**
 *  加载一张网络图片和缺省图片
 *
 *  @param urlStr <#urlStr description#>
 */
- (void) loadImageWithUrlString:(NSString *) urlStr;

@end
