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


@implementation AZStatusFram


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
    CGSize nameSize=[status.user.name sizeWithFont:AZUserNameFont];
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
    CGFloat timeY=CGRectGetMaxY(self.nameLabelF)+AZStatusMargin;
    CGSize timeSize=[status.created_at sizeWithFont:AZUserTimeFont];
    self.timeLabelF=(CGRect){{timeX,timeY},timeSize};

    /** 来源 */
    CGFloat sourceX=CGRectGetMaxX(self.timeLabelF)+AZStatusMargin;
    CGFloat sourceY=timeY;
    CGSize sourceSize=[status.source sizeWithFont:AZUserSourceFont];
    self.sourceLabelF=(CGRect){{sourceX, sourceY},sourceSize};
    
    /** 正文 */
    CGFloat contentX=iconX;
    CGFloat contentY=MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))+AZStatusMargin;
    CGFloat maxW=cellW-2*AZStatusMargin;
    CGSize contentSize=[status.text sizeWithFont:AZUserContentFont maxW:maxW];
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
    CGFloat originalX=0;
    CGFloat originalY=AZStatusMargin;
    CGFloat originalW=cellW;
    self.originalViewF=CGRectMake(originalX, originalY, originalW, originalH);
    
    self.cellHeight=CGRectGetMaxY(self.originalViewF)+AZStatusMargin;
    
    
    CGFloat toolBarY=0;
    /** 转发微博整体 */
       if (status.retweeted_status) {
           
        AZStatus *retweeted_status=status.retweeted_status;
           
        /** 正文 */
        CGFloat retweeted_contentX=AZStatusMargin;
        CGFloat retweeted_contentY=AZStatusMargin;
        CGFloat retweeted_maxW=cellW-2*AZStatusMargin;
        CGSize retweeted_contentSize=[retweeted_status.text sizeWithFont:AZUserContentFont maxW:retweeted_maxW];
        self.retweeted_contentLabelF=(CGRect){{retweeted_contentX,retweeted_contentY},retweeted_contentSize};
        
        /** 转发微博配图 */
        CGFloat retweetedH=0;
        if (retweeted_status.pic_urls.count) {//有配图
            CGFloat retweeted_photoWH=100;
            CGFloat retweeted_photoX=iconX;
            CGFloat retweeted_photoY=CGRectGetMaxY(self.retweeted_contentLabelF)+AZStatusMargin;
            self.retweeted_photoViewF=CGRectMake(retweeted_photoX, retweeted_photoY, retweeted_photoWH, retweeted_photoWH);
            retweetedH=CGRectGetMaxY(self.retweeted_photoViewF)+AZStatusMargin;
            
        }else//没配图
        {
            retweetedH=CGRectGetMaxY(self.retweeted_contentLabelF)+AZStatusMargin;
        }
        
        /** 转发微博整体 */
        CGFloat retweetedX=0;
        CGFloat retweetedY=CGRectGetMaxY(self.contentLabelF)+AZStatusMargin;
        CGFloat retweetedW=cellW;
        self.retweeted_viewF=CGRectMake(retweetedX, retweetedY, retweetedW, retweetedH);
        

           toolBarY=CGRectGetMaxY(self.retweeted_viewF);
    }else
    {
        toolBarY=CGRectGetMaxY(self.originalViewF);


    }
    
    /** 工具条 */
    CGFloat toolBarX=0;
    CGFloat toolBarW=cellW;
    CGFloat toolBarH=35;
    self.toolBarF=CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    self.cellHeight=CGRectGetMaxY(self.toolBarF);

}
@end
