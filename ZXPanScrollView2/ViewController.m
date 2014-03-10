//
//  ViewController.m
//  ZXPanScrollView2
//
//  Created by andyzhang on 14-3-9.
//  Copyright (c) 2014年 andyzhang. All rights reserved.
//

#import "ViewController.h"
#import "ZXPanScrollView.h"
#import "ZXPanCell.h"

@interface ViewController ()<ZXPanScrollViewDataSource>
@property (nonatomic,strong) ZXPanScrollView *panScrollView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _panScrollView = [[ZXPanScrollView alloc] initWithFrame:CGRectMake(0, 30, 320, 568)];
    [_panScrollView registerCellClass: [ZXPanCell class]];
    _panScrollView.dataSource = self;
    _panScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_panScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfViews
{
    return 20;
}

- (UIView *)panScrollView:(ZXPanScrollView *)panScrollView cellAtIndex:(NSInteger)index
{
    ZXPanCell *cell = (ZXPanCell *)[panScrollView dequeReusableCell];
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [cell.webView setBackgroundColor:[UIColor grayColor]];
    NSString *s = [NSString stringWithFormat:@"对不起，内容已被删除。 %d",index];
    [cell.webView loadHTMLString:s baseURL:nil];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 100)];
//    NSLog(@"label alloc!!!!!!!");
//    label.text = [NSString stringWithFormat:@"对不起，内容已被删除。 %d",index];
//    [cell addSubview:label];

    return  cell;
}

@end
