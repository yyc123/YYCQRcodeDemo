//
//  YCQRview.m
//  YYCQRcodeDemo
//
//  Created by 岳永超 on 15/6/26.
//  Copyright (c) 2015年 yungui. All rights reserved.
//

#import "YCQRview.h"


@implementation YCQRview



-(id)init
{
    self = [super init];
    if (self) {
        CGRect firstRect = CGRectMake(SCREEN_WIDTH/2-borderWidth/2, SCREEN_HEIGHT/2-borderWidth/2, borderWidth, borderWidth);
        self.myRect = firstRect;
         [self addScanBackGround];
         [self addScanRange];
        [self addflashBtn];
        
      
    }
    return self;
}
//扫描范围
-(void)addScanRange
{
     UIImageView * borderView = [[UIImageView alloc]initWithFrame:_myRect];
     borderView.image =[UIImage imageNamed:@"扫一扫"];
     [self addSubview:borderView];
    
   
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(_myRect.origin.x, borderView.frame.origin.y+borderWidth+30, borderWidth , 40)];
    labIntroudction.backgroundColor = [UIColor blackColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.layer.cornerRadius = 10;
    labIntroudction.clipsToBounds = YES;
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = [UIFont systemFontOfSize:14];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于方框内，即可自动扫描";
    [self addSubview:labIntroudction];
    
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(_myRect.origin.x, _myRect.origin.y, borderWidth, 2)];
    _line.image = [UIImage imageNamed:@"QRline.png"];
    [self addSubview:_line];
   
    [UIView animateWithDuration:2.5f delay:0 options:UIViewAnimationOptionRepeat animations:^{
        _line.frame = CGRectMake(_myRect.origin.x, _myRect.origin.y+borderWidth-5, borderWidth, 2);
    } completion:^(BOOL finished) {
        _line.frame = CGRectMake(_myRect.origin.x, _myRect.origin.y+5, borderWidth, 2);
    }];


    
  
}
//背景
-(void)addScanBackGround
{
    CGRect cover1Rect = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMinY(_myRect));
    UIView *cover1 = [[UIView alloc]initWithFrame:cover1Rect];
    cover1.backgroundColor = backColor;
    cover1.alpha = 0.6;
    [self addSubview:cover1];
    
    CGRect cover2Rect = CGRectMake(0, CGRectGetMinY(_myRect), CGRectGetMinX(_myRect), CGRectGetHeight(_myRect));
    UIView *cover2 = [[UIView alloc]initWithFrame:cover2Rect];
    cover2.backgroundColor = backColor;
    cover2.alpha = 0.6;
    [self addSubview:cover2];
    
    CGRect cover3Rect = CGRectMake(CGRectGetMaxX(_myRect), CGRectGetMinY(_myRect), CGRectGetMinX(_myRect), CGRectGetHeight(_myRect));
    UIView *cover3 = [[UIView alloc]initWithFrame:cover3Rect];
    cover3.backgroundColor = backColor;
    cover3.alpha = 0.6;
    [self addSubview:cover3];
    
    CGRect cover4Rect = CGRectMake(0, CGRectGetMaxY(_myRect), SCREEN_WIDTH,SCREEN_HEIGHT - CGRectGetMaxY(_myRect));
    UIView *cover4 = [[UIView alloc]initWithFrame:cover4Rect];
    cover4.backgroundColor = backColor;
    cover4.alpha = 0.6;
    
    [self addSubview:cover4];

}
-(void)addflashBtn
{
    self.flashBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 80, 35, 35)];
    [_flashBtn setBackgroundImage:[UIImage imageNamed:@"icon_torch.png"] forState:UIControlStateNormal];
    [_flashBtn addTarget:self action:@selector(flashClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_flashBtn];

}
-(void)flashClick
{
    if (self.flashBtnBlock)
    {
        self.flashBtnBlock();
    }
}
@end
