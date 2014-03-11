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
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSString *currentWebHtml;
@property (nonatomic,strong) NSArray *urlArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _panScrollView = [[ZXPanScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, 548)];
    [_panScrollView registerCellClass: [ZXPanCell class]];
    _panScrollView.dataSource = self;
    _panScrollView.backgroundColor = UIColorFromHex(0xefece3);
    [self.view addSubview:_panScrollView];
    
    self.urlArray = @[@"http://www.sporttery.cn/cache/archives/4/874/93874.arc",@"http://www.sporttery.cn/cache/archives/3/873/93873.arc",@"http://www.sporttery.cn/cache/archives/2/872/93872.arc",@"http://www.sporttery.cn/cache/archives/0/870/93870.arc",@"http://www.sporttery.cn/cache/archives/7/137/91137.arc",@"http://www.sporttery.cn/cache/archives/4/134/91134.arc",@"http://www.sporttery.cn/cache/archives/8/128/91128.arc",@"http://www.sporttery.cn/cache/archives/1/91/91091.arc",@"http://www.sporttery.cn/cache/archives/0/90/91090.arc",@"http://www.sporttery.cn/cache/archives/4/74/91074.arc"];
    
    [_panScrollView scrollToIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfViews
{
    return 9;
}

- (UIView *)panScrollView:(ZXPanScrollView *)panScrollView cellAtIndex:(NSInteger)index
{
    ZXPanCell *cell = (ZXPanCell *)[panScrollView dequeReusableCell];
    [cell configCellForIndex:index detailURL:self.urlArray[index]];

    return  cell;
}


@end
