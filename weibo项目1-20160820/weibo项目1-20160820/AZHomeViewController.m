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

@interface AZHomeViewController ()<AZDropMenuControllerDelegate>
@property(nonatomic,strong)NSArray *statuses;

@end

@implementation AZHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNav];
    [self setupUserinfo];
    [self loadStatus];
   
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
        MYLog(@"%@",responseObject);
        NSArray *statuses=responseObject[@"statuses"];
        self.statuses=statuses;
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
        NSString *name=responseObject[@"name"];
        UIButton *titleBtn=(UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:name forState:UIControlStateNormal];
        
        account.name=name;
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
    //获得微博和用户信息
    NSDictionary *status=self.statuses[indexPath.row];
    NSDictionary *user=status[@"user"];
    
    //设置微博文字和图片
    cell.textLabel.text=user[@"name"];
    cell.detailTextLabel.text=status[@"text"];
    NSString *imageURL=user[@"profile_image_url"];
    UIImage *placeHolder=[UIImage imageNamed:@"avatar_default"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:placeHolder];
    
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
