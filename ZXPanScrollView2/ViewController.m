//
//  ViewController.m
//  ZXPanScrollView2
//
//  Created by andyzhang on 14-3-9.
//  Copyright (c) 2014年 andyzhang. All rights reserved.
//

#import "ViewController.h"
#import "ZXPanScrollView.h"

@interface ViewController ()<ZXPanScrollViewDataSource>
@property (nonatomic,strong) ZXPanScrollView *panScrollView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _panScrollView = [[ZXPanScrollView alloc] initWithFrame:self.view.frame];
    //[_panScrollView registerCellClass: [UITableViewCell class]];
    _panScrollView.dataSource = self;
    [self.view addSubview:_panScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfViews
{
    return 100;
}

- (UIView *)panScrollView:(ZXPanScrollView *)panScrollView cellAtIndex:(NSInteger)index
{
    UIView *cell = [panScrollView dequeReusableCell];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [webView setBackgroundColor:[UIColor grayColor]];
    NSString *s = [NSString stringWithFormat:@"对不起，内容已被删除。 %d",index];
    [webView loadHTMLString:s baseURL:nil];
    [cell addSubview:webView];

    return  cell;
}

@end
