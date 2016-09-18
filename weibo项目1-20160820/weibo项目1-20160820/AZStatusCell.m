//
//  AZStatusCell.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/9/4.
//  Copyright © 2016年 azhang. All rights reserved.
//
#import "AZStatusFram.h"
#import "AZStatusCell.h"
#import "AZStatus.h"
#import "AZUser.h"
#import "AZPhoto.h"
#import "UIImageView+WebCache.h"
#import "AZStatusToolBar.h"
#import "AZStatusPhotosView.h"

@interface AZStatusCell()
/** 原创微博整体 */
@property(nonatomic,weak)UIView *originalView;
/** 头像 */
@property(nonatomic,weak)UIImageView *iconView;
/** vip图标 */
@property(nonatomic,weak)UIImageView *vipView;
/** 配图 */
@property(nonatomic,weak)AZStatusPhotosView *photosView;
/** 名字 */
@property(nonatomic,weak)UILabel *nameLabel;
/** 时间 */
@property(nonatomic,weak)UILabel *timeLabel;
/** 来源 */
@property(nonatomic,weak)UILabel *sourceLabel;
/** 正文 */
@property(nonatomic,weak)UILabel *contentLabel;

/** 转发微博整体 */
@property(nonatomic,weak)UIView *retweeted_view;

/** 转发正文 */
@property(nonatomic,weak)UILabel *retweeted_contentLabel;

/** 转发配图 */
@property(nonatomic,weak)AZStatusPhotosView *retweeted_photosView;

@property(nonatomic,weak)AZStatusToolBar *status_toolBar;


@end

@implementation AZStatusCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    AZStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AZStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    return cell;
}


/**
 *  cell的初始化方法，只调用一次
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        /** 原创微博 */
        [self setupOriginalStatus];
        
        /** 转发微博 */
        [self setupRetweetedStatus];
        
        /** 设置工具条 */
        [self setupToolbar];

    }
    return self;

}



-(void)setupOriginalStatus
{

    /** 原创微博整体 */
    UIView *originalView=[[UIView alloc]init];
    originalView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView=originalView;
    
    /** 头像 */
    UIImageView *iconView=[[UIImageView alloc]init];
    [originalView addSubview:iconView];
    self.iconView=iconView;
    
    /** 名字 */
    UILabel *nameLabel=[[UILabel alloc]init];
    [originalView addSubview:nameLabel];
    nameLabel.font=AZUserNameFont;
    self.nameLabel=nameLabel;
    
    /** vip图标 */
    UIImageView *vipView=[[UIImageView alloc]init];
    [originalView addSubview:vipView];
    self.vipView=vipView;
    
    /** 配图 */
    AZStatusPhotosView *photosView=[[AZStatusPhotosView alloc]init];
    [originalView addSubview:photosView];
    self.photosView=photosView;
    
    /** 时间 */
    UILabel *timeLabel=[[UILabel alloc]init];
    self.timeLabel.numberOfLines=0;
    timeLabel.textColor=[UIColor orangeColor];
    timeLabel.font=AZUserTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel=timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel=[[UILabel alloc]init];
    sourceLabel.font=AZUserSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel=sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel=[[UILabel alloc]init];
    contentLabel.font=AZUserContentFont;
    contentLabel.numberOfLines=0;
    [originalView addSubview:contentLabel];
    self.contentLabel=contentLabel;
}

-(void)setupRetweetedStatus
{
    /** 转发微博整体 */
    UIView *retweeted_view=[[UIView alloc]init];
    retweeted_view.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:retweeted_view];
    self.retweeted_view=retweeted_view;
    
    /** 转发正文 */
    UILabel *retweeted_contentLabel=[[UILabel alloc]init];
    retweeted_contentLabel.font=AZRetweetedContentFont;
    retweeted_contentLabel.numberOfLines=0;
    [retweeted_view addSubview:retweeted_contentLabel];
    self.retweeted_contentLabel=retweeted_contentLabel;
    
    /** 转发配图 */
    AZStatusPhotosView *retweeted_photosView=[[AZStatusPhotosView alloc]init];
    [retweeted_view addSubview:retweeted_photosView];
    self.retweeted_photosView=retweeted_photosView;
    
}

/**
 *  设置cell的frame
 */
-(void)setStatusFrame:(AZStatusFram *)statusFrame
{
    
    _statusFrame=statusFrame;
    
    AZStatus *status=self.statusFrame.status;
    AZUser *user=status.user;
    
    /** 原创微博整体 */
    self.originalView.frame=statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame=statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    
    /** vip图标 */
    if (user.isVip) {
        self.vipView.hidden=NO;
        self.vipView.frame=statusFrame.vipViewF;
        NSString *vipRank=[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image=[UIImage imageNamed:vipRank];
        self.nameLabel.textColor=[UIColor orangeColor];
    }else{//防止cell循环利用后属性没有变回来
        self.vipView.hidden=YES;
        self.nameLabel.textColor=[UIColor blackColor];
    }
   
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame=statusFrame.photoViewF;
        self.photosView.photos=status.pic_urls;
        self.photosView.hidden=NO;
        
    }else
    {
        self.photosView.hidden=YES;
    }
    
    /** 名字 */
    self.nameLabel.frame=statusFrame.nameLabelF;
    self.nameLabel.text=user.name;
    
    /** 时间 */
    NSString *time=status.created_at;
    CGFloat timeX=statusFrame.nameLabelF.origin.x;
    CGFloat timeY=CGRectGetMaxY(statusFrame.nameLabelF)+AZStatusMargin;
    CGSize timeSize=[time sizeWithFont:AZUserTimeFont];
    self.timeLabel.frame=(CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text=time;

    /** 来源 */
    CGFloat sourceX=CGRectGetMaxX(self.timeLabel.frame)+AZStatusMargin;
    CGFloat sourceY=timeY;
    CGSize sourceSize=[status.source sizeWithFont:AZUserSourceFont];
//    MYLog(@"%@",status.source);
    self.sourceLabel.frame=(CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text=status.source;

    /** 正文 */
    self.contentLabel.frame=statusFrame.contentLabelF;
    self.contentLabel.text=status.text;
    
    //判断是否有转发微博
    if (status.retweeted_status) {
        
        AZStatus *retweeted_status=status.retweeted_status;
        
        self.retweeted_view.hidden=NO;
        /** 转发微博整体 */
        self.retweeted_view.frame=statusFrame.retweeted_viewF;
        self.retweeted_view.backgroundColor=AZColor(244, 244, 244);
        
        /** 转发正文 */
        NSString *retweeted_content=[NSString stringWithFormat:@"@%@:%@",user.name,retweeted_status.text];
        self.retweeted_contentLabel.text=retweeted_content;
        self.retweeted_contentLabel.frame=statusFrame.retweeted_contentLabelF;
        
        /** 转发配图 */
        if (retweeted_status.pic_urls.count) {
            
            self.retweeted_photosView.frame=statusFrame.retweeted_photoViewF;
            self.retweeted_photosView.photos=retweeted_status.pic_urls;
//            self.retweeted_photosView.backgroundColor=[UIColor blueColor];
            self.retweeted_photosView.hidden=NO;
        }else
        {
            self.retweeted_photosView.hidden=YES;
        }

    }else
    {
        self.retweeted_view.hidden=YES;
    }
    
    /** 设置工具条 */
    self.status_toolBar.frame=statusFrame.toolBarF;
    self.status_toolBar.status=status;

    
}

/** 设置工具条 */
-(void)setupToolbar
{
    AZStatusToolBar *toolBar=[AZStatusToolBar toolBar];
//    toolBar.backgroundColor=[UIColor clearColor];
    self.status_toolBar=toolBar;
    [self.contentView addSubview:toolBar];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
