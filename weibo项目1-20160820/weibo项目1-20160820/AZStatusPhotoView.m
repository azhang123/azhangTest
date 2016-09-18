//
//  AZStatusPhotoView.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/18.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZStatusPhotoView.h"
#import "AZPhoto.h"
#import "UIImageView+WebCache.h"
@interface AZStatusPhotoView()
@property(nonatomic,weak)UIImageView *gifView;

@end
@implementation AZStatusPhotoView

-(UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image=[UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView=[[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView=gifView;
    }
    
    return _gifView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置拉伸模式为等比拉伸至填充整个UIImageView，并对其进行裁剪
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
    }
    return self;
}

-(void)setPhoto:(AZPhoto *)photo
{
    _photo=photo;
    
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden=![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x=self.width-self.gifView.width;
    self.gifView.y=self.height-self.gifView.height;
}

@end
