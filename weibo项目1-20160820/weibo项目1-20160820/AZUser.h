//
//  AZUser.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/30.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZUser : NSObject

/** string: 好友的昵称  */
@property(nonatomic,copy)NSString *name;

/** string: 帐户的uid */
@property(nonatomic,copy)NSString *uid;

/** string: 用户头像地址（中图），50×50像素 */
@property(nonatomic,copy)NSString *profile_image_url ;

+(AZUser *)userWithDict:(NSDictionary *)dict;

@end
