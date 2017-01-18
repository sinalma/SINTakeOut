//
//  SINWMTypeScrollView.m
//  SinWaiMai
//
//  Created by apple on 16/01/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINWMTypeScrollView.h"

#import "SINNormalButton.h"

@implementation SINWMTypeScrollView
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 初始化子控件
    [self setup];
}


- (void)setup{
    
    // 间距
    CGFloat margin = 10;
    
    // 行数
    int rowCount = 2;
    // 一页列数
    int columnCount = 5;
    
    // 求出总共的列数
    // 这里可以用公式
    CGFloat colFloat = self.wMTypeCount % 2;
    int colInt = self.wMTypeCount / 2;
    
    if (colFloat > 0) {
        colInt += 1;
    }
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.width - (columnCount + 1) * margin) / columnCount;
    CGFloat h = (150 - (rowCount + 1) * margin) / rowCount;
    
    
    CGFloat contentSizeW = margin + colInt * (w + margin);
    CGFloat contentSizeH = margin + rowCount * (h + margin);
    
    self.contentSize = CGSizeMake(contentSizeW, contentSizeH);
    
    for (int i = 0; i < self.wMTypeCount; i++) {
        
        SINNormalButton *btn = [[SINNormalButton alloc] init];
        
        [btn setImage:[UIImage imageNamed:self.wMTypeImgNs[i]] forState:UIControlStateNormal];
        [btn setTitle:self.wMTypeNames[i] forState:UIControlStateNormal];
        
        
        int row = i / colInt;
        int col = i % colInt;
        
        x = margin + (col * (w + margin));
        y = margin + (row * (h + margin));
        
        btn.frame = CGRectMake(x, y, w, h);
        
        btn.tag = i;
        [btn addTarget:self action:@selector(wMTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

- (void)wMTypeBtnClick:(SINNormalButton *)btn
{
    NSLog(@"点击了外卖类型 -> %@",btn.titleLabel.text);
}

@end