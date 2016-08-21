//
//  AZSearchBar.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/21.
//  Copyright © 2016年 azhang. All rights reserved.
//
#import "UIView+Extension.h"
#import "AZSearchBar.h"

@implementation AZSearchBar

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        self.font=[UIFont systemFontOfSize:14];
        self.background=[UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder=@"请输入搜索条件";
        
        UIImageView *searchIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.width=30;
        searchIcon.height=30;
        searchIcon.contentMode=UIViewContentModeCenter;
        self.leftView=searchIcon;
        self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
}


+(instancetype)searchBar
{
    return [[self alloc]init];
}

@end
