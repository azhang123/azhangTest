//
//  AZStatus.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/30.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AZUser;
@interface AZStatus : NSObject

/** idstr 	string 	字符串型的微博ID  */
@property(nonatomic,copy)NSString *idstr;

/** text 	string 	微博信息内容  */
@property(nonatomic,copy)NSString *text;

/**	object	微博作者的用户信息字段 */
@property(nonatomic,strong)AZUser *user;

/** string 	微博创建时间 */
@property(nonatomic,copy)NSString *created_at;

/** string 	微博来源 */
@property(nonatomic,copy)NSString *source;

/** NSArray 微博配图 */
@property(nonatomic,strong)NSArray *pic_urls;

@property(nonatomic,assign,readonly)int mem;

/** 转发微博 */
@property(nonatomic,strong)AZStatus *retweeted_status;

/** 评论数 */
@property(nonatomic,assign)int comments_count;
/** 转发数 */
@property(nonatomic,assign)int reposts_count;
/** 点赞数 */
@property(nonatomic,assign)int attitudes_count;





//+(AZStatus *)statusWithDict:(NSDictionary *)dict;

@end
