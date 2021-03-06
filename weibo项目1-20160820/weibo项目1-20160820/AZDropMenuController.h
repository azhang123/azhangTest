//
//  AZDropMenuController.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/21.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AZDropMenuController;
@protocol AZDropMenuControllerDelegate <NSObject>
@optional
-(void)dropDownMenuDidShow:(AZDropMenuController *)menu;
-(void)dropDownMenuDidDismiss:(AZDropMenuController *)menu;

@end

@interface AZDropMenuController : UIView

@property(nonatomic,weak) id<AZDropMenuControllerDelegate> delegate;


/**
 *  内容
 */
@property(nonatomic,strong)UIView *content;

/**
 *  内容控制器
 */
@property(nonatomic,strong)UIViewController *contentController;

/**
 *  显示
 */
-(void)showFrom:(UIView *)from;

/**
 *  返回
 */
-(void)dismiss;



+(instancetype)menu;

@end
