//
//  NSString+Extension.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/17.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 *  获得文字内容的尺寸
 *
 *  @param text 文字内容
 *  @param font 字体
 *
 *  @return 文字尺寸
 */
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
