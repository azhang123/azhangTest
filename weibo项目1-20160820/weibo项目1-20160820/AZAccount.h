//
//  AZAccount.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/28.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZAccount : NSObject<NSCoding>

/** accessToken: 用户访问微博的唯一标识 */
@property(nonatomic,copy)NSString *access_token;

/** expires_in: accessToken的过期时间，单位秒 */
@property(nonatomic,copy)NSNumber *expires_in;

/** uid: 申请应用时的AppKey */
@property(nonatomic,copy)NSString *uid;

@property(nonatomic,strong)NSDate *create_time;


+(instancetype)accountWithDictionary:(NSDictionary *)dict;

@end
