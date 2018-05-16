//
//  coustomTapView.m
//  cloudPlatformApp
//
//  Created by 刘瑞杰 on 2018/1/18.
//  Copyright © 2018年 刘瑞杰. All rights reserved.
//

#import "coustomTapView.h"

@implementation coustomTapView
- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor brownColor];
        self.userInteractionEnabled = YES;
        
        //添加单击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
  
    }
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];

  
   
//      _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, 30) byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    _path = [UIBezierPath bezierPath];
    if ([self.type isEqualToString:@"1"]) {
        [_path addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 10 startAngle:-(M_PI + M_PI / 4.0) endAngle:-(M_PI - M_PI / 4.0) clockwise:YES];
        [_path addLineToPoint:CGPointMake(101, 101)];
        UIBezierPath *p = [UIBezierPath bezierPath];
        [p addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 80 startAngle:-(M_PI + M_PI / 4.0) endAngle:-(M_PI - M_PI / 4.0) clockwise:YES];
        [_path appendPath:p];
        [_path moveToPoint:CGPointMake(53, 262)];
        [_path addLineToPoint:CGPointMake(101, 211)];

    }else if([self.type isEqualToString:@"2"]){
    [_path addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 10 startAngle:-(M_PI - M_PI / 4.0) endAngle:-(M_PI / 4.0) clockwise:YES];
    [_path addLineToPoint:CGPointMake(213, 100)];
        UIBezierPath *p = [UIBezierPath bezierPath];
    [p addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 80 startAngle:-(M_PI - M_PI / 4.0) endAngle:-(M_PI / 4.0) clockwise:YES];
    [_path appendPath:p];
    [_path moveToPoint:CGPointMake(53, 53)];
    [_path addLineToPoint:CGPointMake(101, 101)];

    } else if([self.type isEqualToString:@"3"]){
        [_path addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 10 startAngle:M_PI / 4.0 endAngle:-(M_PI + M_PI / 4.0) clockwise:YES];
        [_path addLineToPoint:CGPointMake(101, 213)];
         UIBezierPath *p = [UIBezierPath bezierPath];
        [p addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0,
                                             self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 80 startAngle:M_PI / 4.0 endAngle:-(M_PI + M_PI / 4.0) clockwise:YES];
        [_path appendPath:p];
        [_path moveToPoint:CGPointMake(262, 262)];
        [_path addLineToPoint:CGPointMake(211, 211)];
    } else {
         [_path addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 10 startAngle:-(M_PI / 4.0) endAngle:M_PI / 4.0 clockwise:YES];
        [_path addLineToPoint:CGPointMake(262, 262)];
        UIBezierPath *p = [UIBezierPath bezierPath];
        [p addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0) radius:self.bounds.size.width / 2.0 - 80 startAngle:-(M_PI / 4.0) endAngle:M_PI / 4.0 clockwise:YES];
        [_path appendPath:p];
        [_path moveToPoint:CGPointMake(262, 262)];
        [_path addLineToPoint:CGPointMake(211, 211)];
    }
//    [_path moveToPoint:CGPointMake(0, 50)];
//    [_path addLineToPoint:CGPointMake(0, 200)];
//    [_path addQuadCurveToPoint:CGPointMake(200, 50) controlPoint:CGPointMake(100, 200)];
    
//     _path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, 30) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(15, 15)];
    
//    _path = [UIBezierPath bezierPath];
//    [_path moveToPoint:CGPointMake(0, longSide  + k)];
//    [_path addLineToPoint:CGPointMake(shortSide, + k)];
//    [_path addLineToPoint:CGPointMake(shortSide + shortSide + shortSide,  k)];
//    [_path addLineToPoint:CGPointMake(SIZE, longSide + k)];
//    [_path addLineToPoint:CGPointMake(shortSide * 3, longSide * 2 + k)];
//    [_path addLineToPoint:CGPointMake(shortSide, longSide * 2 + k)];
//    [_path closePath];
    
    // step 2: 根据路径生成蒙板
    _maskLayer = [CAShapeLayer layer];
//        _maskLayer.position = self.center;
    _maskLayer.path = [_path CGPath];
//    _maskLayer.lineWidth = 80;
//    _maskLayer.fillColor = [UIColor clearColor].CGColor;
//    _maskLayer.strokeColor = [UIColor orangeColor].CGColor;
//    [self.layer addSublayer:_maskLayer];
//     step 3: 添加蒙版
    self.layer.mask = _maskLayer;
    
    
//    self.backgroundColor = [UIColor orangeColor];
}

//点击事件
- (void) click:(UITapGestureRecognizer *) tap
{
//    switch (tap.state) {
//        case UIGestureRecognizerStateBegan:
//            if (_block) {
//                _block();
//            }
//            break;
//        case UIGestureRecognizerStateChanged:
//            if (_block) {
//                _block();
//            }
//            break;
//       case UIGestureRecognizerStateCancelled:
//            if (_cancel) {
//                _cancel();
//            }
//        default:
//           
//            break;
//    }
//    if (_block) {
//        _block();
//    }
//    if (tap.state == UIGestureRecognizerStateEnded) {
//        if (_cancel) {
//            _cancel();
//        }
//    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_block) {
        _block();
    }
}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    if (_cancel) {
//        _cancel();
//    }
//}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    if (_cancel) {
        _cancel();
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //如果点击的区域在所创建的路径范围内
    if (CGPathContainsPoint(_path.CGPath, NULL, point, NO)) {

        return [super hitTest:point withEvent:event];

    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
