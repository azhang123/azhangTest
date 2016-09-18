//
//  NSDate+Extension.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/17.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断是否为今年
 */
-(BOOL)isThisYear;

/**
 *  判断是否为今天
 */
-(BOOL)isToday;

/**
 *  判断是否为昨天
 */
-(BOOL)isYesterday;

@end
