//
//  AZTestViewController.m
//  weibo项目1-20160820
//
//  Created by azhang on 16/8/20.
//  Copyright © 2016年 azhang. All rights reserved.
//

#import "AZTestViewController.h"
#import "AZTest2TableController.h"
@interface AZTestViewController ()

@end

@implementation AZTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)push {
    AZTest2TableController *test2=[[AZTest2TableController alloc]init];
    [self.navigationController pushViewController:test2 animated:YES];
}



@end
