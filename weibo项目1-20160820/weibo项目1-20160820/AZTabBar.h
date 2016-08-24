//
//  AZTabBar.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/22.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AZTabBar;

@protocol AZTabBarDelegate<UITabBarDelegate>
-(void)AZTabBarDidClickPlusBtn:(AZTabBar *)tabBar;
@end

@interface AZTabBar : UITabBar
@property(nonatomic,weak) id<AZTabBarDelegate> delegate;

@end
