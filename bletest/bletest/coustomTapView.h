//
//  coustomTapView.h
//  cloudPlatformApp
//
//  Created by 刘瑞杰 on 2018/1/18.
//  Copyright © 2018年 刘瑞杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coustomTapView : UIView

typedef void (^HexagonButtonBlock)(void);

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) HexagonButtonBlock block; //点击事件
@property (nonatomic, copy) void(^cancel)();
@property (nonatomic, strong) NSString *right;
//添加点击事件
@property (nonatomic, strong) UILabel *myLab;
@property (nonatomic, copy) NSString *type;

@end
