//
//  AZAccountTool.h
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/28.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AZAccount.h"
@class AZAccount;
@interface AZAccountTool : NSObject

+(AZAccount *)account;
+(void)saveAccount:(AZAccount *)account;
@end
