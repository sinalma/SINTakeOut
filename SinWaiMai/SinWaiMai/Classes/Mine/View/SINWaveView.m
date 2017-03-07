//
//  SINWaveView.m
//  SinWaiMai
//
//  Created by apple on 05/03/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINWaveView.h"

@interface SINWaveView ()
{
    UIColor *_waterColor;
    CGFloat _waterLineY;
    CGFloat _waveAmplitude;
    CGFloat _waveCycle;
    BOOL increase;
    CADisplayLink *_waveDisplayLink;
}

@end

@implementation SINWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _waveAmplitude = 3.0;
        _waveCycle = 1.0;
        increase = NO;
        _waterColor=[UIColor colorWithRed:88/255.0f green:202/255.0f blue:139/255.0f alpha:1];
        _waterLineY=120.0;
        
        
        _waveDisplayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)runWave
{
    
    if (increase) {
        _waveAmplitude += 0.02;
    }else{
        _waveAmplitude -= 0.02;
    }
    
    
    if (_waveAmplitude<=1) {
        increase = YES;
    }
    
    if (_waveAmplitude>=1.5) {
        increase = NO;
    }
    
    _waveCycle+=0.1;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    //初始化画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //推入
    CGContextSaveGState(context);
    
    
    //定义前波浪path
    CGMutablePathRef frontPath = CGPathCreateMutable();
    
    //定义后波浪path
    CGMutablePathRef backPath=CGPathCreateMutable();
    
    //定义前波浪反色path
    CGMutablePathRef frontReversePath = CGPathCreateMutable();
    
    //定义后波浪反色path
    CGMutablePathRef backReversePath=CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    
    
    //前波浪位置初始化
    float frontY=_waterLineY;
    CGPathMoveToPoint(frontPath, NULL, 0, frontY);
    
    //前波浪反色位置初始化
    float frontReverseY=_waterLineY;
    CGPathMoveToPoint(frontReversePath, NULL, 0,frontReverseY);
    
    //后波浪位置初始化
    float backY=_waterLineY;
    CGPathMoveToPoint(backPath, NULL, 0, backY);
    
    //后波浪反色位置初始化
    float backReverseY=_waterLineY;
    CGPathMoveToPoint(backReversePath, NULL, 0, backReverseY);
    
    for(float x=0;x<=320;x++){
        
        //前波浪绘制
        frontY= _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + _waterLineY;
        CGPathAddLineToPoint(frontPath, nil, x, frontY);
        
        //后波浪绘制
        backY= _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + _waterLineY;
        CGPathAddLineToPoint(backPath, nil, x, backY);
        
        
        if (x>=100) {
            
            //后波浪反色绘制
            backReverseY= _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + _waterLineY;
            CGPathAddLineToPoint(backReversePath, nil, x, backReverseY);
            
            //前波浪反色绘制
            frontReverseY= _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + _waterLineY;
            CGPathAddLineToPoint(frontReversePath, nil, x, frontReverseY);
        }
    }
    
    //后波浪绘制
    CGContextSetFillColorWithColor(context, [[UIColor orangeColor] CGColor]);
    CGPathAddLineToPoint(backPath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, _waterLineY);
    CGPathCloseSubpath(backPath);
    CGContextAddPath(context, backPath);
    CGContextFillPath(context);
    
    //推入
    CGContextSaveGState(context);
    
    //后波浪反色绘制
    CGPathAddLineToPoint(backReversePath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(backReversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(backReversePath, nil, 100, _waterLineY);
    
    CGContextAddPath(context, backReversePath);
    CGContextClip(context);
    
    
    // CGContextSaveGState(context);
    //弹出
    CGContextRestoreGState(context);
    
    //前波浪绘制
    CGContextSetFillColorWithColor(context, [_waterColor CGColor]);
    CGPathAddLineToPoint(frontPath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, _waterLineY);
    CGPathCloseSubpath(frontPath);
    CGContextAddPath(context, frontPath);
    CGContextFillPath(context);
    
    //推入
    CGContextSaveGState(context);
    
    
    //前波浪反色绘制
    CGPathAddLineToPoint(frontReversePath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(frontReversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(frontReversePath, nil, 100, _waterLineY);
    
    CGContextAddPath(context, frontReversePath);
    CGContextClip(context);
    
    //推入
    CGContextSaveGState(context);
    
    
    //释放
    CGPathRelease(backPath);
    CGPathRelease(backReversePath);
    CGPathRelease(frontPath);
    CGPathRelease(frontReversePath);
}


@end
