//
//  AZStatusPhotosView.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/18.
//  Copyright © 2016年 azhang. All rights reserved.
//
#define AZStatusPhotosWH 95
#define AZStatusPhotosMargin 7.5
#define AZStatusPhotosMaxCol(count) ((count==4)?2:3)

#import "AZStatusPhotoView.h"
#import "AZStatusPhotosView.h"

@implementation AZStatusPhotosView

/**
 *  根据图片数量返回图片父控件的尺寸
 */
+(CGSize)sizeWithCount:(int)count
{
    int maxCols=AZStatusPhotosMaxCol(count);
    int cols=(count<maxCols)?count:maxCols;
    CGFloat photosW=cols*AZStatusPhotosWH+(cols-1)*AZStatusPhotosMargin;
    int rows=(count+maxCols-1)/maxCols;
    CGFloat photosH=rows*AZStatusPhotosWH+(rows-1)*AZStatusPhotosMargin;
    
    return CGSizeMake(photosW,photosH);
}

/**
 *  创建并设置图片子空间的显示状态
 */
-(void)setPhotos:(NSArray *)photos
{
    _photos=photos;
    
    int photosCount=photos.count;
    
    while(self.subviews.count<photosCount) {//创建子图片控件
        AZStatusPhotoView *photoView=[[AZStatusPhotoView alloc]init];
        [self addSubview:photoView];
        
    }
    for (int i=0; i<self.subviews.count; i++) {
        AZStatusPhotoView *photoView=self.subviews[i];
        
        if (i<photosCount) { //显示
            photoView.photo=photos[i];
            photoView.hidden=NO;
            
        }else{//隐藏
            photoView.hidden=YES;
        }
    }
    
}

/**
 *  设置图片的尺寸
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int photosCount=self.photos.count;
    int maxCols=AZStatusPhotosMaxCol(photosCount);
    
    for (int i=0; i<photosCount; i++) {
        AZStatusPhotoView *photoView=self.subviews[i];
        int col=i%maxCols;
        int row=i/maxCols;
        photoView.x=col*(AZStatusPhotosWH+AZStatusPhotosMargin);
        photoView.y=row*(AZStatusPhotosWH+AZStatusPhotosMargin);
        photoView.size=CGSizeMake(AZStatusPhotosWH, AZStatusPhotosWH);
    }
    
    
}


@end
