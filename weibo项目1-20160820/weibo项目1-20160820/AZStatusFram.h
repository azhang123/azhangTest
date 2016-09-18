//
//  AZStatusFram.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/4.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 微博昵称字体 */
#define AZUserNameFont [UIFont systemFontOfSize:15]
/** 微博时间字体 */
#define AZUserTimeFont [UIFont systemFontOfSize:12]
/** 微博来源字体 */
#define AZUserSourceFont [UIFont systemFontOfSize:12]
/** 微博正文字体 */
#define AZUserContentFont [UIFont systemFontOfSize:14]
/** 转发微博正文字体 */
#define AZRetweetedContentFont [UIFont systemFontOfSize:14]

#define AZStatusMargin 10

@class AZStatus;
@interface AZStatusFram : NSObject
/** 原创微博整体 */
@property(nonatomic,assign)CGRect originalViewF;
/** 头像 */
@property(nonatomic,assign)CGRect iconViewF;
/** vip图标 */
@property(nonatomic,assign)CGRect vipViewF;
/** 配图 */
@property(nonatomic,assign)CGRect photoViewF;
/** 名字 */
@property(nonatomic,assign)CGRect nameLabelF;
/** 时间 */
@property(nonatomic,assign)CGRect timeLabelF;
/** 来源 */
@property(nonatomic,assign)CGRect sourceLabelF;
/** 正文 */
@property(nonatomic,assign)CGRect contentLabelF;

/** 转发微博整体 */
@property(nonatomic,assign)CGRect retweeted_viewF;

/** 转发正文 */
@property(nonatomic,assign)CGRect retweeted_contentLabelF;

/** 转发配图 */
@property(nonatomic,assign)CGRect retweeted_photoViewF;

/** 微博模型 */
@property(nonatomic,strong)AZStatus *status;

/** cell的高度 */
@property(nonatomic,assign)CGFloat cellHeight;

/** 底部的工具条 */
@property(nonatomic,assign)CGRect toolBarF;


@end
