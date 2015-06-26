//
//  YCQRViewController.m
//  YYCQRcodeDemo
//
//  Created by 岳永超 on 15/6/26.
//  Copyright (c) 2015年 yungui. All rights reserved.
//

#import "YCQRViewController.h"
#import "YCQRview.h"
@interface YCQRViewController ()

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) YCQRview *cameraView; //二维码界面

@property(nonatomic,assign) BOOL isOpen;
@end

@implementation YCQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"二维码扫描";
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    if (_device.torchMode == AVCaptureTorchModeOn)
    {
        
        [_device lockForConfiguration:nil];
        
        [_device setTorchMode:AVCaptureTorchModeOff];
        
        [_device unlockForConfiguration];
        _isOpen =NO;
        
    }
}
- (void)setupCamera
{
    self.cameraView  = [[YCQRview alloc] init];
    _cameraView.translatesAutoresizingMaskIntoConstraints = NO;
    _cameraView.clipsToBounds  = YES;
    self.cameraView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:_cameraView];

    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
   
    _preview.frame =self.view.layer.bounds;
    [_cameraView.layer insertSublayer:self.preview atIndex:0];
    CGFloat  x = _cameraView.myRect.origin.x;
    CGFloat y = _cameraView.myRect.origin.y;
    

     [_output setRectOfInterest:CGRectMake(y/SCREEN_HEIGHT,x/SCREEN_WIDTH,borderWidth/SCREEN_HEIGHT,borderWidth/SCREEN_WIDTH)];
    // Start
    [_session startRunning];
    [_cameraView setFlashBtnBlock:^{
        if (_isOpen == NO) {
            
            if (_device.torchMode == AVCaptureTorchModeOff) {
                
                [_device lockForConfiguration:nil];
                
                [_device setTorchMode:AVCaptureTorchModeOn];
                
                [_device unlockForConfiguration];
                _isOpen =YES;
            }

        }else
        {
            
            if (_device.torchMode == AVCaptureTorchModeOn)
            {
                
                        [_device lockForConfiguration:nil];
                
                        [_device setTorchMode:AVCaptureTorchModeOff];
                
                        [_device unlockForConfiguration];
                _isOpen =NO;
                        
            }

        }
    }];
}



#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
    
    [_session stopRunning];
   
#warning --扫描完成在此回调--
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"======%@",stringValue);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
