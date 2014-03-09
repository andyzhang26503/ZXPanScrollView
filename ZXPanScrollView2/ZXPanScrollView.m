//
//  ZXPanScrollView.m
//  ZXPanScrollView2
//
//  Created by andyzhang on 14-3-9.
//  Copyright (c) 2014年 andyzhang. All rights reserved.
//

#import "ZXPanScrollView.h"

@interface ZXPanScrollView ()<UIScrollViewDelegate>
{
    Class _cellClass;
}
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableSet *reusableViewSet;
@end

@implementation ZXPanScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        self.reusableViewSet = [NSMutableSet set];
        
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setNeedsLayout];
}

- (void)setDataSource:(id<ZXPanScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self refreshPanScrollView];
}

- (void)refreshPanScrollView
{
    NSInteger cellCount = [self.dataSource numberOfViews];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.scrollView.contentSize = CGSizeMake(screenSize.width*cellCount, screenSize.height);
    
    NSInteger upperIndex = ceilf(self.scrollView.contentOffset.x/screenSize.width);
    NSInteger bottomIndex = floorf(self.scrollView.contentOffset.x/screenSize.width);
    
    NSArray *scrollViewSubviews = [self scrollViewSubviews];
    [scrollViewSubviews enumerateObjectsUsingBlock:^(UIView *view,NSUInteger idx,BOOL *stop){
        if (view.frame.origin.x+screenSize.width<=self.scrollView.contentOffset.x) {
            [self recycleCell:view];
        }else if (view.frame.origin.x-screenSize.width>=self.scrollView.contentOffset.x){
            [self recycleCell:view];
        }
    }];
    for (int i=bottomIndex; i<upperIndex+1; i++) {
        if ([self cellAtIndex:i]) {
            NSLog(@"self cellAtIndex in!! i==%d",i);
        }else{
            UIView *cellView = [self.dataSource panScrollView:self cellAtIndex:i];
            cellView.frame = CGRectMake(i*screenSize.width, 0, screenSize.width, screenSize.height);
            [self.scrollView addSubview:cellView];
            
            NSLog(@"add subview in!! i==%d",i);
        }
    }
}

- (UIView *)cellAtIndex:(NSInteger)index
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    NSArray *scrollViewSubviews = [self scrollViewSubviews];
    for (UIView *view in scrollViewSubviews) {
        if (view.frame.origin.x>self.scrollView.contentOffset.x&&view.frame.origin.x<self.scrollView.contentOffset.x+screenSize.width) {
            return view;
        }
    }
    return nil;
}

- (NSArray *)scrollViewSubviews
{
    NSMutableArray *subviews = [NSMutableArray array];
    for (id v in self.scrollView.subviews) {
        if ([v isKindOfClass:[UIView class]]) {
            [subviews addObject:v];
        }
    }
    return subviews;
}

- (void)recycleCell:(UIView *)view
{
    [view removeFromSuperview];
    [self.reusableViewSet addObject:view];
}

- (UIView *)dequeReusableCell
{
    UIView *view = [self.reusableViewSet anyObject];
    if (view) {
        [self.reusableViewSet removeObject:view];
    }else{
        view = [[UIView alloc] init];
    }
    return view;
}

- (void)registerCellClass:(Class)cclass
{
    _cellClass = cclass;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
