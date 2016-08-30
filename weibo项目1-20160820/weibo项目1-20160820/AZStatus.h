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
@property(nonatomic,copy)NSString *id_str;

/** text 	string 	微博信息内容  */
@property(nonatomic,copy)NSString *text;

/**	object	微博作者的用户信息字段 */
@property(nonatomic,strong)AZUser *user;

+(AZStatus *)statusWithDict:(NSDictionary *)dict;

@end
