//
//  AZHomeViewController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "AZSearchBar.h"
#import "AZDropMenuController.h"
#import "AZTitleMenuController.h"
#import "AZAccountTool.h"
#import "AFNetworking.h"
#import "AZTitleButton.h"
#import "UIImageView+WebCache.h"
#import "AZStatus.h"
#import "AZUser.h"
#import "MJExtension.h"
#import "AZStatusCell.h"
#import "AZStatusFram.h"

@interface AZHomeViewController ()<AZDropMenuControllerDelegate>
/**
 *  微博数组(里面放的都是AZStatus模型，一个AZStatus对象代表一条微博)
 */
@property(nonatomic,strong)NSMutableArray *statusFrames;

@end

@implementation AZHomeViewController

-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames=[NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNav];
    [self setupUserinfo];
//    [self loadStatus];
    [self setupRefresh];
    
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:105 target:self selector:@selector(acquireUnreadInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
   
}

/**
 *  获取未读消息数
 */
-(void)acquireUnreadInfo
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    AZAccount *account=[AZAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    params[@"uid"]=account.uid;
    
    
    //3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSString *infoCount=[responseObject[@"status"]description];
        MYLog(@"成功调用了acquireUnreadInfo方法：%@",responseObject);
    
    //注册远程推送通知
        UIUserNotificationType  types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings  *mySettings  = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [UIApplication sharedApplication].applicationIconBadgeNumber=infoCount.intValue;
        
        if ([infoCount isEqualToString:@"0"]) {//如果是0，清空数字
            self.tabBarItem.badgeValue=nil;
        }else
        {//非0情况
            self.tabBarItem.badgeValue=infoCount;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"请求失败%@",error);
    }];
    
}


/**
 *  集成刷新模块
 */
-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(loadRefreshStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.进入刷新状态，但并不出发UIControlEventValueChanged点击事件
    [control endRefreshing];
    
    //3.马上加载数据
    [self loadRefreshStatus:control];
    

}

/**
 *  将微博字典数组转为AZStatusFrames数组
 */
-(NSMutableArray *)statusFrameWithArray:(NSArray *)array
{
    //1.将微博字典数组转为AZStatus数组
    NSArray *newStatuses=[AZStatus objectArrayWithKeyValuesArray:array];
    
    //2.将AZStatus数组转为AZStatusFrames数组
    NSMutableArray *newStatusFrames=[NSMutableArray array];
    for (AZStatus *status in newStatuses) {
        AZStatusFram *statusf=[[AZStatusFram alloc]init];
        statusf.status=status;
        [newStatusFrames addObject:statusf];
    }
    return newStatusFrames;
}

/**
 *  刷新微博操作
 */
-(void)loadRefreshStatus:(UIRefreshControl *)control
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    //设置请求参数
    AZAccount *account=[AZAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    
    AZStatusFram *firstStatusF=[self.statusFrames firstObject];
    if (firstStatusF.status) {
        params[@"since_id"]=firstStatusF.status.idstr;
    }
    //发起请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        MYLog(@"responseObject%@",responseObject);
        //获得新微博的frame
        NSMutableArray *newStatusFrames=[self statusFrameWithArray:responseObject[@"statuses"]];
        MYLog(@"%@",responseObject);
        //插入新微博
        NSRange range=NSMakeRange(0, newStatusFrames.count);
        MYLog(@"%d",newStatusFrames.count);
        NSIndexSet *inset=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusFrames atIndexes:inset];
        //更新微博
        [self.tableView reloadData];
        [control endRefreshing];
        
        //显示微博刷新数量
        [self presentStatusRefreshingCount:newStatusFrames.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"请求失败:%@",error);
        [control endRefreshing];
    }];
}
/**
 *  显示微博刷新数量
 */
-(void)presentStatusRefreshingCount:(int)count
{
    //1.创建label
    UILabel *label=[[UILabel alloc]init];
    
    //2.设置label属性
    label.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:16];
    label.width=[UIScreen mainScreen].bounds.size.width;
    label.height=35;
    label.y=64-label.height;
    
    if (count==0) {
        label.text=@"没有新的微博数据更新，稍候再试";
    }else
    {
        label.text=[NSString stringWithFormat:@"%d条微博更新",count];
    }
    
    //3.添加label至导航栏
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4.创建动画
    CGFloat duration=1;
    [UIView animateWithDuration:duration animations:^{
        label.transform=CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay=1;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}



-(void)loadStatus
{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    //2.所需参数
    AZAccount *account=[AZAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token ;
    params[@"count"]=@10;
    
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        MYLog(@"%@",responseObject);
        //取得微博数组
        NSMutableArray *StatusFrames=[self statusFrameWithArray:responseObject[@"statuses"]];
        
        //添加微博
//        for (NSDictionary *dict in dictArray) {
//             AZStatus *status=[AZStatus statusWithDict:dict];
//            [self.statuses addObject:status];
//        }
        [self.statusFrames addObjectsFromArray:StatusFrames];
        [self.tableView reloadData];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MYLog(@"%@",error);
    }];

}

-(void)setupNav
{
    //设置左右导航栏
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem ItemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem ItemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    
    //创建按钮
    AZTitleButton *titleButton=[[AZTitleButton alloc]init];
    titleButton.width=150;
    titleButton.height=30;
    
    //设置按钮的文字和图片
    NSString *name=[AZAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    //监听按钮的点击事件
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView=titleButton;
    
}

-(void)setupUserinfo
{
    //1.请求管理者
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    //2.所需参数
    AZAccount *account=[AZAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token ;
    params[@"uid"]=account.uid ;


    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        MYLog(@"%@",responseObject);
    
        AZUser *user=[AZUser objectWithKeyValues:responseObject];
        UIButton *titleBtn=(UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        account.name=user.name;
        [AZAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MYLog(@"%@",error);
    }];
}

/**
 *  下拉按钮的点击方法
 */
-(void)titleClick:(UIButton *)buttons
{
    //新建下拉菜单视图控制器
    AZDropMenuController *dropMenu=[AZDropMenuController menu];
    dropMenu.delegate=self;
    //新建下拉菜单里的内容视图控制器
    AZTitleMenuController *vc=[[AZTitleMenuController alloc]init];
    vc.view.height=44*3;
    
    dropMenu.contentController=vc;
    
    [dropMenu showFrom:buttons];
    

    
//    //取出最上方的窗口
//    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
//    
//    //设置蒙板
//    UIView *view=[[UIView alloc]init];
//    view.frame=window.bounds;
//    [window addSubview:view];
//    
//    //弹出下拉菜单
//    UIImageView *menuView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
//    menuView.width=217;
//    menuView.height=217;
//    [window addSubview:menuView];
}


-(void)friendSearch
{
    MYLog(@"friendSearch");
}

-(void)pop
{
    MYLog(@"pop");
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AZStatusCell *cell=[AZStatusCell cellWithTableView:tableView];
//    //获得微博和用户信息
//    NSDictionary *status=self.statuses[indexPath.row];
//    NSDictionary *user=status[@"user"];
    
    //设置微博文字和图片
//    cell.textLabel.text=user[@"name"];
//    cell.detailTextLabel.text=status[@"text"];
//    NSString *imageURL=user[@"profile_image_url"];
    
    cell.statusFrame=self.statusFrames[indexPath.row];
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AZStatusFram *cellFrame=self.statusFrames[indexPath.row];
    
    return cellFrame.cellHeight;
}

#pragma mark-AZDropDownMenu的代理方法
/**
 *  下拉菜单图片向上
 */
-(void)dropDownMenuDidShow:(AZDropMenuController *)menu
{
    UIButton *buttons=(UIButton *)self.navigationItem.titleView;
    buttons.selected=YES;
    MYLog(@"haha");
    
}

/**
 *  下拉菜单图片向下
 */
-(void)dropDownMenuDidDismiss:(AZDropMenuController *)menu
{
    UIButton *buttons=(UIButton *)self.navigationItem.titleView;
    buttons.selected=NO;
    MYLog(@"haah12");
}


@end
