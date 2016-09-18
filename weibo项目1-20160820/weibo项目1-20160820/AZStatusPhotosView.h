//
//  AZStatusPhotosView.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/18.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZStatusPhotosView : UIView

@property(nonatomic,strong)NSArray *photos;

+(CGSize)sizeWithCount:(int) count;

@end
