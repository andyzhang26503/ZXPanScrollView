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

@property (nonatomic,assign) CGFloat nextIndex;
@end

@implementation ZXPanScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        //_scrollView.showsHorizontalScrollIndicator = NO;
        
        self.reusableViewSet = [NSMutableSet set];
        
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshPanScrollView];
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

- (void)reloadPanScrollView
{
    //[[self scrollViewSubviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self refreshPanScrollView];
}

- (void)refreshPanScrollView
{
    NSInteger cellCount = [self.dataSource numberOfViews];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.scrollView.contentSize = CGSizeMake(screenSize.width*cellCount, 0);
    
    NSInteger upperIndex = MIN(ceilf(self.scrollView.contentOffset.x/screenSize.width), cellCount-1);
    NSInteger bottomIndex = MAX(floorf(self.scrollView.contentOffset.x/screenSize.width), 0);
    
    NSArray *scrollViewSubviews = [self scrollViewSubviews];
    [scrollViewSubviews enumerateObjectsUsingBlock:^(UIView *view,NSUInteger idx,BOOL *stop){
        if (view.frame.origin.x+screenSize.width<=self.scrollView.contentOffset.x) {
            [self recycleCell:view];
        }else if (view.frame.origin.x-screenSize.width>=self.scrollView.contentOffset.x){
            [self recycleCell:view];
        }
    }];
    for (int i=bottomIndex; i<=upperIndex; i++) {
        if ([self cellAtIndex:i]) {
        }else{
            UIView *cellView = [self.dataSource panScrollView:self cellAtIndex:i];
            cellView.frame = CGRectMake(i*screenSize.width, 0, screenSize.width, screenSize.height);
            [self.scrollView addSubview:cellView];
        }
    }
}

- (UIView *)cellAtIndex:(NSInteger)index
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    NSArray *scrollViewSubviews = [self scrollViewSubviews];
    for (UIView *view in scrollViewSubviews) {
        //if (view.frame.origin.x>self.scrollView.contentOffset.x&&view.frame.origin.x<self.scrollView.contentOffset.x+screenSize.width) {
        if (view.frame.origin.x == screenSize.width*index) {
            return view;
        }
    }
    return nil;
}

- (NSArray *)scrollViewSubviews
{
    NSMutableArray *subviews = [NSMutableArray array];
    for (id v in self.scrollView.subviews) {
        if ([v isKindOfClass:[_cellClass class]]) {
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
        view = [[_cellClass alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return view;
}

- (void)registerCellClass:(Class)cclass
{
    _cellClass = cclass;
}

- (void)scrollToIndex:(NSInteger)index
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    //[self.scrollView scrollRectToVisible:CGRectMake(screenSize.width*index, 0, screenSize.width, screenSize.height-20) animated:YES];
    [self.scrollView setContentOffset:CGPointMake(screenSize.width*index, 0) animated:YES];
}

@end
