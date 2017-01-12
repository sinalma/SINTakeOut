//
//  SINNavigationController.m
//  SinWaiMai
//
//  Created by apple on 11/01/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINNavigationController.h"

#import "SINHomepageViewController.h"

@interface SINNavigationController ()

@end

@implementation SINNavigationController
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [self.view insertSubview:view belowSubview:self.navigationBar];
        // 传一个空的图片或者一张透明的图片(分辨率无所谓)
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
        
        self.navigationBar.layer.masksToBounds = YES;// 去掉横线（没有这一行代码导航栏的最下面还会有一个横线）
    }
    return self;
}

@end