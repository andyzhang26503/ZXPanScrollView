//
//  ZXPanScrollView.h
//  ZXPanScrollView2
//
//  Created by andyzhang on 14-3-9.
//  Copyright (c) 2014年 andyzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXPanScrollView;
@protocol ZXPanScrollViewDataSource <NSObject>

- (NSInteger)numberOfViews;
- (UIView *)panScrollView:(ZXPanScrollView *)panScrollView cellAtIndex:(NSInteger)index;

@end

@interface ZXPanScrollView : UIView
@property (nonatomic,weak) id<ZXPanScrollViewDataSource> dataSource;

- (UIView *)dequeReusableCell;
- (void)registerCellClass:(Class)cclass;
@end
