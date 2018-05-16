//
//  ViewController.m
//  bletest
//
//  Created by 刘瑞杰 on 2018/1/25.
//  Copyright © 2018年 刘瑞杰. All rights reserved.
//

#import "ViewController.h"
#import "coustomTapView.h"
#import "RootViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "fh.h"
#import<objc/runtime.h>
#import "SVIndefiniteAnimatedView.h"
@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (strong, nonatomic) CBCentralManager *centralManager;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (nonatomic, strong) NSMutableArray *dataArr1;

@property (nonatomic, strong) NSMutableArray *dataArr2;

@property (nonatomic, strong) CBPeripheral *myP;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat strokeThickness;
@end

@implementation ViewController
- (CBUUID *)servicesUUID{
    Byte byte[] = {255, 240};
    NSData *serviceData = [[NSData alloc] initWithBytes:byte length:2];
    return [CBUUID UUIDWithData:serviceData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         [[UIApplication sharedApplication].delegate window].rootViewController = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
//    });
  
//    coustomTapView *v  = [[coustomTapView alloc] initWithFrame:self.myImage.frame];
//    v.backgroundColor = [UIColor clearColor];
//    v.block = ^(){
//        self.myImage.image = [UIImage imageNamed:@"right"];
//    };
//    v.cancel = ^{
//        self.myImage.image = [UIImage imageNamed:@"normal"];
//    };
//    [self.view addSubview:v];
//    coustomTapView *v2  = [[coustomTapView alloc] initWithFrame:self.myImage.frame];
//    v2.type = @"1";
//    v2.backgroundColor = [UIColor clearColor];
//    v2.block = ^(){
//        self.myImage.image = [UIImage imageNamed:@"left"];
//    };
//    v2.cancel = ^{
//        self.myImage.image = [UIImage imageNamed:@"normal"];
//    };
//    [self.view addSubview:v2];
//    coustomTapView *v3  = [[coustomTapView alloc] initWithFrame:self.myImage.frame];
//    v3.type = @"2";
//    v3.backgroundColor = [UIColor clearColor];
//    v3.block = ^(){
//        self.myImage.image = [UIImage imageNamed:@"up"];
//    };
//    v3.cancel = ^{
//        self.myImage.image = [UIImage imageNamed:@"normal"];
//    };
//    [self.view addSubview:v3];
//    coustomTapView *v4  = [[coustomTapView alloc] initWithFrame:self.myImage.frame];
//    v4.type = @"3";
//    v4.backgroundColor = [UIColor clearColor];
//    v4.block = ^(){
//        self.myImage.image = [UIImage imageNamed:@"down"];
//    };
//    v4.cancel = ^{
//        self.myImage.image = [UIImage imageNamed:@"normal"];
//    };
//    [self.view addSubview:v4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:@{CBCentralManagerOptionShowPowerAlertKey : @1}];
    self.dataArr1 = [NSMutableArray array];
    self.dataArr2 = [NSMutableArray array];
//    for (int i = 0; i < 9; i++) {
//        fh *m = [fh new];
//        m.isCan = @"1";
//        [self.dataArr1 addObject:m];
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.dataArr2 addObjectsFromArray:self.dataArr1];
//        fh *f = self.dataArr2[0];
//        f.isCan = @"100";
//
//        fh *h = self.dataArr1[0];
//        NSLog(@"%@", h.isCan);
//    });
    [self configSlider];
    self.radius = 24.0;
    self.strokeThickness = 2.0;
    [self layoutAnimatedLayer];
}
- (void)layoutAnimatedLayer {
    CALayer *layer = [self indefiniteAnimatedLayer];
    [self.view.layer addSublayer:layer];
    
    CGFloat widthDiff = CGRectGetWidth(self.view.bounds) - CGRectGetWidth(layer.bounds);
    CGFloat heightDiff = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(layer.bounds);
    layer.position = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(layer.bounds) / 2 - widthDiff / 2, CGRectGetHeight(self.view.bounds) - CGRectGetHeight(layer.bounds) / 2 - heightDiff / 2);
}

- (CAShapeLayer*)indefiniteAnimatedLayer {
    if(1) {
        CGPoint arcCenter = CGPointMake(self.radius+self.strokeThickness/2+5, self.radius+self.strokeThickness/2+5);
        UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:self.radius startAngle:(CGFloat) (M_PI*3/2) endAngle:(CGFloat) (M_PI/2+M_PI*5) clockwise:YES];
        
       CAShapeLayer *_indefiniteAnimatedLayer = [CAShapeLayer layer];
        _indefiniteAnimatedLayer.contentsScale = [[UIScreen mainScreen] scale];
        _indefiniteAnimatedLayer.frame = CGRectMake(0.0f, 0.0f, arcCenter.x*2, arcCenter.y*2);
        _indefiniteAnimatedLayer.fillColor = [UIColor clearColor].CGColor;
        _indefiniteAnimatedLayer.strokeColor = [UIColor blueColor].CGColor;
        _indefiniteAnimatedLayer.lineWidth = self.strokeThickness;
        _indefiniteAnimatedLayer.lineCap = kCALineCapRound;
        _indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel;
        _indefiniteAnimatedLayer.path = smoothedPath.CGPath;
        
        CALayer *maskLayer = [CALayer layer];
        
        //        NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
        //        NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
        //        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        //
        //        NSString *path = [imageBundle pathForResource:@"angle-mask" ofType:@"png"];
        
        maskLayer.contents = (__bridge id)[[UIImage imageNamed:@"angle-mask"] CGImage];
        maskLayer.frame = _indefiniteAnimatedLayer.bounds;
        _indefiniteAnimatedLayer.mask = maskLayer;
        
        NSTimeInterval animationDuration = 1;
        CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.fromValue = (id) 0;
        animation.toValue = @(M_PI*2);
        animation.duration = animationDuration;
        animation.timingFunction = linearCurve;
        animation.removedOnCompletion = NO;
        animation.repeatCount = INFINITY;
        animation.fillMode = kCAFillModeForwards;
        animation.autoreverses = NO;
        [_indefiniteAnimatedLayer.mask addAnimation:animation forKey:@"rotate"];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = INFINITY;
        animationGroup.removedOnCompletion = NO;
        animationGroup.timingFunction = linearCurve;
        
        CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStartAnimation.fromValue = @0.015;
        strokeStartAnimation.toValue = @0.515;
        
        CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @0.485;
        strokeEndAnimation.toValue = @0.985;
        
        animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
        [_indefiniteAnimatedLayer addAnimation:animationGroup forKey:@"progress"];
        return _indefiniteAnimatedLayer;
    }
    return nil;
}


- (void)configSlider
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([UISlider class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char *nameP = ivar_getName(var);
        NSLog(@"%@", [NSString stringWithUTF8String:nameP]);
    }

    
    //定义两张图片
    UIImage *minImage = [UIImage imageNamed:@"cannonball"];
    UIImage *maxImage = [UIImage imageNamed:@"cannonball副本"];
    
    //-----将图片中间的一个点去方法------
    UIImage *imageMin = [minImage stretchableImageWithLeftCapWidth:minImage.size.width/2 topCapHeight:minImage.size.height/2];
    UIImage *imageMax = [maxImage  stretchableImageWithLeftCapWidth:maxImage.size.width/2 topCapHeight:maxImage.size.height/2];
    //设置拇指图片
    //[slider setThumbImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    //设置滑竿上拇指， 左边和右边的图片
    [self.mySlider setMinimumTrackImage:imageMin forState:UIControlStateNormal];
    [self.mySlider setMaximumTrackImage:imageMax forState:UIControlStateNormal];
    self.mySlider.minimumValue = 0;
    self.mySlider.maximumValue = 255;
    //添加一个事件， 改变self.view的背景颜色
    [self.mySlider setValue:@1 forKeyPath:@"_thumbView.hidden"];
    NSLog(@"+++%@+++",[self.mySlider valueForKey:@"_thumbView"]);
    
//    [self.mySlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"%ld", (long)central.state);
//    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"8ce255c0-200a-11e0-ac64-0800200c9a66"]]
//                                                options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@NO, CBCentralManagerScanOptionSolicitedServiceUUIDsKey : @[[CBUUID UUIDWithString:@"8ce255c0-200a-11e0-ac64-0800200c9a66"]]}];
    [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"FFE0"]]
                                                options:nil];
//    [self.centralManager scanForPeripheralsWithServices:nil
//                                                options:nil];

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
//    [central stopScan];
    NSLog(@"%@***advertisementData:%@，RSSI:%@", [peripheral.identifier UUIDString], advertisementData,RSSI);
    NSLog(@"设备名称---%@ ___ %@", peripheral.name, peripheral.identifier);
//    self.myP = peripheral;
//    [self.centralManager connectPeripheral:peripheral options:nil];


}



- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{    [peripheral setDelegate:self];
    [peripheral discoverServices:nil];
    
}
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    if (error) {
       NSLog(@"didDiscoverServices error:%@",[error localizedDescription]);
    } else {
        for (CBService *service in peripheral.services)
        {
            NSLog(@"Service found with UUID: %@", service.UUID);
             [peripheral discoverCharacteristics:nil forService:service];
        }

    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    for (int i = 0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = service.characteristics[i];
        if ([[c.UUID UUIDString] isEqualToString:@"FFE1"]) {
            NSData *data = [@"up" dataUsingEncoding:NSUTF16StringEncoding];
            [self.myP writeValue:[self hexToBytes:@"20000000012345678"] forCharacteristic:c type:CBCharacteristicWriteWithResponse];
        }
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    
     [peripheral readValueForCharacteristic:characteristic];
    
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    
    
    
    
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    NSData *da = characteristic.value;
    NSString *str = [[NSString alloc] initWithData:da encoding:NSUTF16StringEncoding];
    
}

-(NSData *)hexToBytes:(NSString *)hexString {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx < hexString.length; idx++) {
        NSRange range = NSMakeRange(idx, 1);
        NSString* hexStr = [hexString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    
    return data;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
