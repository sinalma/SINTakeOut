//
//  SINQRCodeWebView.m
//  QRCode
//
//  Created by apple on 22/04/2017.
//  Copyright © 2017 sinalma. All rights reserved.
//

#import "SINQRCodeWebView.h"
#import "SINQRCodeConst.h"
#import <WebKit/WebKit.h>

@interface SINQRCodeWebView () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *wkWebView;

@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation SINQRCodeWebView

static CGFloat const navigationBarHeight = 64;
static CGFloat const progressViewHeight = 2;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.wkWebView];
        [self addSubview:self.progressView];
    }
    return self;
}

+ (instancetype)webViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (void)setProgressViewColor:(UIColor *)progressViewColor
{
    _progressViewColor = progressViewColor;
    
    if (progressViewColor) {
        _progressView.tintColor = progressViewColor;
    }
}

- (void)setIsNavigationBarOrTranslucent:(BOOL)isNavigationBarOrTranslucent
{
    _isNavigationBarOrTranslucent = isNavigationBarOrTranslucent;
    if (isNavigationBarOrTranslucent == YES) {// 导航栏存在且有穿透效果
        _progressView.frame = CGRectMake(0, navigationBarHeight, self.frame.size.width, progressViewHeight);
        
        
    }else// 没有穿透效果
    {
        _progressView.frame = CGRectMake(0, 0, self.frame.size.width, progressViewHeight);
    }
}

// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        self.progressView.alpha = 1.0;
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        if (self.wkWebView.estimatedProgress >= 0.97) {
            [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }else
        {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if (self.QRCodeWebViewDelegate && [self.QRCodeWebViewDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.QRCodeWebViewDelegate webViewDidStartLoad:self];
    }
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if (self.QRCodeWebViewDelegate && [self.QRCodeWebViewDelegate respondsToSelector:@selector(webView:didCommitWithURL:)]) {
        [self.QRCodeWebViewDelegate webView:self didCommitWithURL:self.wkWebView.URL];
    }
    
    self.navigationItemTitle = self.wkWebView.title;
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.navigationItemTitle = self.wkWebView.title;
    if (self.QRCodeWebViewDelegate && [self.QRCodeWebViewDelegate respondsToSelector:@selector(webView:didFinishLoadWithURL:)]) {
        [self.QRCodeWebViewDelegate webView:self didFinishLoadWithURL:self.wkWebView.URL];
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (self.QRCodeWebViewDelegate && [self.QRCodeWebViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.QRCodeWebViewDelegate webView:self didFailLoadWithError:error];
    }
}

- (void)loadRequest:(NSURLRequest *)request
{
    [self.wkWebView loadRequest:request];
}

- (void)loadHTMLString:(NSString *)HTMLString
{
    [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
}

- (void)reloadData
{
    [self.wkWebView reload];
}

- (void)dealloc
{
    SINLog(@"SINQRCodeWebView - dealloc");
    
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        // KVO
        [self.wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor clearColor];
        // 高度默认，导航栏穿透效果
        _progressView.frame = CGRectMake(0, navigationBarHeight, self.frame.size.width,progressViewHeight);
        // 进度条颜色
        _progressView.tintColor = [UIColor greenColor];
    }
    return _progressView;
}

@end
