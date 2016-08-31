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

@interface AZHomeViewController ()<AZDropMenuControllerDelegate>
/**
 *  微博数组(里面放的都是AZStatus模型，一个AZStatus对象代表一条微博)
 */
@property(nonatomic,strong)NSMutableArray *statuses;

@end

@implementation AZHomeViewController

-(NSMutableArray *)statuses
{
    if (!_statuses) {
        self.statuses=[NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNav];
    [self setupUserinfo];
    [self loadStatus];
    [self setupRefresh];
   
}

/**
 *  集成刷新模块
 */
-(void)setupRefresh
{
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(loadRefreshStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];

}

/**
 *  刷新微博操作
 */
-(void)loadRefreshStatus:(UIRefreshControl *)control
{
    //请求管理者
    AFHTTPRequestOperationManager *mgr=[[AFHTTPRequestOperationManager alloc]init];
    //设置请求参数
    AZAccount *account=[AZAccountTool account];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=account.access_token;
    AZStatus *firstStatus=[self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"]=firstStatus.id_str;
    }
    //发起请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        MYLog(@"responseObject%@",responseObject);
        //获得新微博
        NSArray *newStatuses=[AZStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //插入新微博
        NSRange range=NSMakeRange(0, newStatuses.count);
        NSIndexSet *inset=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:inset];
        //更新微博
        [self.tableView reloadData];
        [control endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MYLog(@"请求失败:%@",error);
        [control endRefreshing];
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
        NSArray *dictArray=responseObject[@"statuses"];
        //添加微博
//        for (NSDictionary *dict in dictArray) {
//             AZStatus *status=[AZStatus statusWithDict:dict];
//            [self.statuses addObject:status];
//        }
        NSArray *array=[AZStatus objectArrayWithKeyValuesArray:dictArray];
        [self.statuses addObjectsFromArray:array];
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
        
//        MYLog(@"%@",responseObject);
    
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
    return self.statuses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    //获得微博和用户信息
//    NSDictionary *status=self.statuses[indexPath.row];
//    NSDictionary *user=status[@"user"];
    
    //设置微博文字和图片
//    cell.textLabel.text=user[@"name"];
//    cell.detailTextLabel.text=status[@"text"];
//    NSString *imageURL=user[@"profile_image_url"];
    AZStatus *status=self.statuses[indexPath.row];
    AZUser *user=status.user;
    cell.textLabel.text=user.name;
    cell.detailTextLabel.text=status.text;
    
    UIImage *placeHolder=[UIImage imageNamed:@"avatar_default"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:placeHolder];
    
    return cell;
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
