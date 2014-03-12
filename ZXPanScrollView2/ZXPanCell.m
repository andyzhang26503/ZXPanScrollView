//
//  ZXPanCell.m
//  ZXPanScrollView2
//
//  Created by andyzhang on 14-3-10.
//  Copyright (c) 2014年 andyzhang. All rights reserved.
//

#import "ZXPanCell.h"

@interface ZXPanCell ()<UIWebViewDelegate>
@end

@implementation ZXPanCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.webView.backgroundColor = UIColorFromHex(0xefece3);
        //self.webView.scrollView.bounces = NO;
        //self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.delegate = self;
        [self addSubview:self.webView];
    }
    return self;
}

- (void)configCellForIndex:(NSInteger)index detailURL:(NSString *)url
{
    [self loadInfoDetailAtIndex:url];
}

- (void)loadInfoDetailAtIndex:(NSString *)detailURL
{
    
    NSError *fileError;
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *detailHTMLPath = [[NSBundle mainBundle] pathForResource:@"InformationDetail" ofType:@"html"];
    NSString *detailHTML = [NSString stringWithContentsOfFile:detailHTMLPath encoding:NSUTF8StringEncoding error:&fileError];
    [self.webView loadHTMLString:detailHTML baseURL:nil];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        NSError *error;
        NSString *htmlString  = [NSString stringWithContentsOfURL:[NSURL URLWithString:detailURL] encoding:encoding error:&error];
        NSString *htmlStringNew = @"";
        if (!htmlString) {
            htmlStringNew = @"对不起，内容已被删除。";
        }else{
            htmlStringNew = [self replaceSpecialCharacterWithString:htmlString];
        }
        
        if (error) {
            NSLog(@"error = %@",error.localizedDescription);
        }
        NSString *detailHTMLNew = [detailHTML stringByReplacingOccurrencesOfString:@"载入中..." withString:htmlStringNew];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webView loadHTMLString:detailHTMLNew baseURL:nil];

        });
    });
    
}

- (NSString *)replaceSpecialCharacterWithString:(NSString *)oldString
{
    NSString *cleanedString = [oldString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return cleanedString;
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
