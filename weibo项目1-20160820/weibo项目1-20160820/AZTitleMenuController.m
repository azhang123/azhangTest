//
//  AZTitleMenuController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/21.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZTitleMenuController.h"

@interface AZTitleMenuController ()

@end

@implementation AZTitleMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}
/**
 *  加载cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建标识
    static NSString *ID = @"cell";
    //根据标识从缓存池中获取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //缓存池中没有对应的cell，新建一个cell
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row==0) {
        cell.textLabel.text=@"好友";
    }else if (indexPath.row==1){
        cell.textLabel.text=@"密友";
    }else{
        cell.textLabel.text=@"全部";
    }
    
    
    return cell;
}
@end
