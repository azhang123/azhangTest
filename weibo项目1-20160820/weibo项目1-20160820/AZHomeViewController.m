//
//  AZHomeViewController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZHomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"
#import "AZSearchBar.h"
#import "AZDropMenuController.h"
#import "AZTitleMenuController.h"

@interface AZHomeViewController ()

@end

@implementation AZHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem ItemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem ItemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    
    //创建按钮
    UIButton *titleButton=[[UIButton alloc]init];
    titleButton.width=150;
    titleButton.height=30;
    //设置按钮的文字和图片
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font=[UIFont systemFontOfSize:17];
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    //设置按钮文字和图片的排布
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    //添加按钮
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView=titleButton;
    
}

/**
 *  下拉按钮的点击方法
 */
-(void)titleClick:(UIButton *)button
{
    //新建下拉菜单视图控制器
    AZDropMenuController *dropMenu=[AZDropMenuController menu];
    //新建下拉菜单里的内容视图控制器
    AZTitleMenuController *vc=[[AZTitleMenuController alloc]init];
    vc.view.height=44*3;
    
    dropMenu.contentController=vc;
    
    [dropMenu showFrom:button];
    

    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
