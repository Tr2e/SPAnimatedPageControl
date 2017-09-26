//
//  SPAnimatedPageControl.h
//  UNI-MALL
//
//  Created by Tree on 2017/9/22.
//  Copyright © 2017年 UNI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPAnimatedPageControl : UIControl

@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;

@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@end
