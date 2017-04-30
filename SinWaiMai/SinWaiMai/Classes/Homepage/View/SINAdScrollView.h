//
//  SINAdScrollView.h
//  SinWaiMai
//
//  Created by apple on 16/01/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//  广告模块

#import <UIKit/UIKit.h>

@interface SINAdScrollView : UIScrollView

@property (nonatomic,strong) NSArray *adImgArr;

- (void)addTimerFromAD;

- (void)removeTimerFromAD;
@end
