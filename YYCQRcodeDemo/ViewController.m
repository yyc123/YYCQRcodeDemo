//
//  ViewController.m
//  YYCQRcodeDemo
//
//  Created by 岳永超 on 15/6/26.
//  Copyright (c) 2015年 yungui. All rights reserved.
//

#import "ViewController.h"
#import "YCQRViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goNextVC:(id)sender {
    YCQRViewController * vc = [[YCQRViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
