//
//  ViewController.m
//  YYCQRcodeDemo
//
//  Created by 岳永超 on 15/6/26.
//  Copyright (c) 2015年 yungui. All rights reserved.
//

#import "ViewController.h"
#import "YCQRViewController.h"

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goNextVC:(id)sender {
    YCQRViewController * vc = [[YCQRViewController alloc]init];
    if (SIMULATOR==1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:[NSString stringWithFormat:@"请在真机上扫描二维码"]
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
