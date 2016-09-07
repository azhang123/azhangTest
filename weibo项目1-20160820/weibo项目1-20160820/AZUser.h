//
//  AZUser.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/30.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZUser : NSObject

/** string: 用户的昵称  */
@property(nonatomic,copy)NSString *name;

/** string: 帐户的uid */
@property(nonatomic,copy)NSString *uid;

/** string: 用户头像地址（中图），50×50像素 */
@property(nonatomic,copy)NSString *profile_image_url ;

/** int: 会员类型 */
@property(nonatomic,assign)int mbtype;

/** int: 会员等级 */
@property(nonatomic,assign)int mbrank;

/** 是否是会员 */
@property(nonatomic,assign)BOOL isVip;


//+(AZUser *)userWithDict:(NSDictionary *)dict;

@end
