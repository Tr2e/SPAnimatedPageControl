//
//  SPAnimatedPageControl.m
//  UNI-MALL
//
//  Created by Tree on 2017/9/22.
//  Copyright © 2017年 UNI. All rights reserved.
//

#import "SPAnimatedPageControl.h"
#import <Masonry.h>

static CGFloat lineWidth = 5;
static CGFloat lineMargin = 4;
static CGFloat lineHeight = 2.5;
static CGFloat lineLongWidth = 12;

@interface SPAnimatedPageControl()
@property (nonatomic, assign) CGSize pageControlSize;
@property (nonatomic, strong) UIView *currentPageView;
@property (nonatomic, copy) NSMutableArray<UIView *> *linesArray;
@end

@implementation SPAnimatedPageControl
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    for (NSInteger i = 0; i < self.linesArray.count; i ++) {
        UIView *line = self.linesArray[i];
        line.backgroundColor = i?[[UIColor whiteColor] colorWithAlphaComponent:0.5]:[UIColor whiteColor];
    }
}

#pragma mark - Config
- (void)calculateSizeOfPageControl{
    CGFloat width = (lineWidth + lineMargin) * (_numberOfPages - 1) + lineLongWidth;
    CGSize size = CGSizeMake(width, lineHeight);
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    self.pageControlSize = size;
    [self initializeForLine];
}

- (void)initializeForLine{
    for (NSInteger i = 0; i < _numberOfPages; i ++) {
        UIView *line = [[UIView alloc] init];
        line.width = (i?lineWidth:lineLongWidth);
        line.cornerRadius = 1.25;
        line.clipsToBounds = YES;
        [self addSubview:line];
        [self.linesArray addObject:line];
        [self setConstraintForLine:line index:i];
        if (i==0){
            self.currentPageView = line;
        };
    }
}

- (void)setConstraintForLine:(UIView *)line index:(NSInteger)index{
    if (index == 0) {
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
            make.width.equalTo(@(lineLongWidth));
        }];
        return;
    }
    UIView *lastLine = self.linesArray[index-1];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lastLine.mas_right).offset(lineMargin);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@(lineWidth));
        if (index == _numberOfPages - 1){
            make.right.equalTo(self);
        }
    }];
}

#pragma mark - Set/Get
- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    [self calculateSizeOfPageControl];
}
- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    UIView *line = self.linesArray[currentPage];
    [UIView beginAnimations:nil context:nil];
    [self.currentPageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(lineWidth));
    }];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(lineLongWidth));
    }];
    [UIView setAnimationDuration:0.25f];
    [self layoutIfNeeded];
    [UIView commitAnimations];
    self.currentPageView.backgroundColor = _pageIndicatorTintColor;
    line.backgroundColor =_currentPageIndicatorTintColor;
    self.currentPageView = line;
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    _pageIndicatorTintColor = pageIndicatorTintColor;
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (NSMutableArray<UIView *> *)linesArray{
    if (!_linesArray) {
        _linesArray = [NSMutableArray array];
    }
    return _linesArray;
}
@end
