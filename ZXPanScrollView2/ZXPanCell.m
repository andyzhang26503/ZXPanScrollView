//
//  ZXPanCell.m
//  ZXPanScrollView2
//
//  Created by andyzhang on 14-3-10.
//  Copyright (c) 2014年 andyzhang. All rights reserved.
//

#import "ZXPanCell.h"

@implementation ZXPanCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.webView.backgroundColor = [UIColor greenColor];
        self.webView.scrollView.bounces = NO;
        [self addSubview:self.webView];
    }
    return self;
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
