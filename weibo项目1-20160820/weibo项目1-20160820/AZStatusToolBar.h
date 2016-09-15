//
//  AZStatusToolBar.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/9.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AZStatus;
@interface AZStatusToolBar : UIView

+(instancetype)toolBar;

@property(nonatomic,strong)AZStatus *status;


@end
