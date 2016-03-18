//
//  CDHeaderCollectionViewCell.h
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDHeaderCollectionViewCellDelegate <NSObject>

- (void) pushToDetail:(NSUInteger) film_id;

@end

@interface CDHeaderCollectionViewCell : UICollectionViewCell

@property(nonatomic, copy) NSString *countries;
@property(nonatomic, weak) id<CDHeaderCollectionViewCellDelegate> delegate;


@end
