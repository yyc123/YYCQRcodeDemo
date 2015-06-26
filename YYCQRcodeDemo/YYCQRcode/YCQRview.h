//
//  YCQRview.h
//  YYCQRcodeDemo
//
//  Created by 岳永超 on 15/6/26.
//  Copyright (c) 2015年 yungui. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define borderWidth 290
#define backColor [UIColor blackColor]

@interface YCQRview : UIView


@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, strong) UIButton *flashBtn;

@property(nonatomic ,strong)void(^flashBtnBlock)();

@property(nonatomic ,assign)CGRect myRect;
@end
