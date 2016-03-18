//
//  CDDetailCell.h
//  FattyMovie
//
//  Created by luo on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *genres;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *countries;
@property (weak, nonatomic) IBOutlet UILabel *directors;
@property (weak, nonatomic) IBOutlet UILabel *casts;
@property (weak, nonatomic) IBOutlet UILabel *summary;

@end
