//
//  AZStatusCell.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/4.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AZStatusFram;

@interface AZStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)AZStatusFram *statusFrame;

@end
