//
//  AZStatusFram.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/4.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZStatusFram.h"
#import "AZStatus.h"
#import "AZUser.h"

#define AZStatusMargin 10

@implementation AZStatusFram


/**
 *  获得文字内容的尺寸
 *
 *  @param text 文字内容
 *  @param font 字体
 *
 *  @return 文字尺寸
 */
-(CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithText:(NSString *)text Font:(UIFont *)font
{
    return [self sizeWithText:text Font:font maxW:MAXFLOAT];
}

-(void)setStatus:(AZStatus *)status
{
    _status=status;
    AZUser *user=status.user;
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width;
    
    /** 头像 */
    CGFloat iconX=AZStatusMargin;
    CGFloat iconY=AZStatusMargin;
    CGFloat iconW=50;
    CGFloat iconH=50;
    self.iconViewF=CGRectMake(iconX, iconY, iconW, iconH);
    
    /** 名字 */
    CGFloat nameX=CGRectGetMaxX(self.iconViewF)+AZStatusMargin;
    CGFloat nameY=iconY;
    CGSize nameSize=[self sizeWithText:user.name Font:AZUserNameFont];
    self.nameLabelF=(CGRect){{nameX,nameY},nameSize};

    /** vip图标 */
    if (user.isVip) {
        CGFloat vipX=CGRectGetMaxX(self.nameLabelF)+AZStatusMargin;
        CGFloat vipY=iconY;
        CGFloat vipH=nameSize.height;
        CGFloat vipW=vipH;
        self.vipViewF=CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    /** 时间 */
    CGFloat timeX=nameX;
    CGFloat timeY=CGRectGetMaxY(self.vipViewF)+AZStatusMargin;
    CGSize timeSize=[self sizeWithText:status.created_at Font:AZUserTimeFont];
    self.timeLabelF=(CGRect){{timeX, timeY},timeSize};

    /** 来源 */
    CGFloat sourceX=CGRectGetMaxX(self.timeLabelF)+AZStatusMargin;
    CGFloat sourceY=CGRectGetMaxY(self.vipViewF)+AZStatusMargin;
    CGSize sourceSize=[self sizeWithText:status.source Font:AZUserSourceFont];
    self.timeLabelF=(CGRect){{sourceX, sourceY},sourceSize};
    
    /** 正文 */
    CGFloat contentX=iconX;
    CGFloat contentY=MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+AZStatusMargin;
    CGFloat maxW=cellW-2*AZStatusMargin;
    CGSize contentSize=[self sizeWithText:status.text Font:AZUserContentFont maxW:maxW];
    self.contentLabelF=(CGRect){{contentX,contentY},contentSize};

    /** 配图 */
    CGFloat originalH=0;
    if (status.pic_urls.count) {//有配图
        CGFloat photoWH=100;
        CGFloat photoX=iconX;
        CGFloat photoY=CGRectGetMaxY(self.contentLabelF)+AZStatusMargin;
        self.photoViewF=CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH=CGRectGetMaxY(self.photoViewF)+AZStatusMargin;

    }else//没配图
    {
        originalH=CGRectGetMaxY(self.contentLabelF)+AZStatusMargin;
    }
    
    /** 原创微博整体 */
    CGFloat originalX=AZStatusMargin;
    CGFloat originalY=AZStatusMargin;
    CGFloat originalW=cellW-2*AZStatusMargin;
    self.originalViewF=CGRectMake(originalX, originalY, originalW, originalH);
    
    self.cellHeight=CGRectGetMaxY(self.originalViewF)+AZStatusMargin;
    
}
@end
