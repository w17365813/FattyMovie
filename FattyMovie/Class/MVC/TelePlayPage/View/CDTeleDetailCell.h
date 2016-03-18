//
//  CDTeleDetailCell.h
//  FattyMovie
//
//  Created by luo on 16/3/8.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDTeleDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *film_type;
@property (weak, nonatomic) IBOutlet UILabel *show_time;
@property (weak, nonatomic) IBOutlet UILabel *countries;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *update_time;
@property (weak, nonatomic) IBOutlet UILabel *update_cycle;
@property (weak, nonatomic) IBOutlet UILabel *casts;
@property (weak, nonatomic) IBOutlet UILabel *summary;

@end
