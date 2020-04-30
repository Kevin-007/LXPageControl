//
//  ViewController.m
//  LXPageControl
//
//  Created by LOUXUN-K on 2020/4/30.
//  Copyright © 2020 LOUXUN-K. All rights reserved.
//

#import "ViewController.h"

#import "LXPageControl.h"

#import <SDCycleScrollView/SDCycleScrollView.h>

#import <Masonry/Masonry.h>


@interface ViewController ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView1;
@property (weak, nonatomic) IBOutlet LXPageControl *pageControl1;

@property (strong, nonatomic)SDCycleScrollView *cycleView2;
@property (strong, nonatomic)LXPageControl *pageControl2;

@property (strong, nonatomic)SDCycleScrollView *cycleView3;
@property (strong, nonatomic)LXPageControl *pageControl3;

@property (strong, nonatomic)SDCycleScrollView *cycleView4;
@property (strong, nonatomic)LXPageControl *pageControl4;

/** images*/
@property(nonatomic, strong)NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}

-(void)setupUI{
    
    self.images = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588243563518&di=d12bf6b2f28954c0b8187e0fa6a72066&imgtype=0&src=http%3A%2F%2F5.26923.com%2Fdownload%2Fpic%2F000%2F333%2Fe7ecbc2659873f6c348f8fbdd8b6d53b.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588243563517&di=b8a264a64ea75a8a9a7fd02361647a2a&imgtype=0&src=http%3A%2F%2Fimage.huahuibk.com%2Fuploads%2F20190222%2F23%2F1550850387-MFLyASvKBD.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588243563516&di=fd22f0287172e254136f66565131634d&imgtype=0&src=http%3A%2F%2Fimage.biaobaiju.com%2Fuploads%2F20191101%2F23%2F1572622192-OcRVLodZxP.jpg"
    ];
    
    //居中样式
    self.cycleView1.imageURLStringsGroup = self.images;
    self.cycleView1.showPageControl = NO;
    
    self.pageControl1.numberOfPages = self.images.count;
    self.cycleView1.delegate = self;
    __weak typeof(self) weakSelf =self;
    self.pageControl1.actionHandle = ^(NSInteger index) {
        [weakSelf.cycleView1 makeScrollViewScrollToIndex:index];
    };
    
    //左边样式
    self.cycleView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:self.images];
    self.cycleView2.delegate = self;
    self.cycleView2.showPageControl = NO;
    
    self.pageControl2 = [[LXPageControl alloc] init];
    self.pageControl2.actionHandle = ^(NSInteger index) {
        [weakSelf.cycleView2 makeScrollViewScrollToIndex:index];
    };
    [self.view addSubview:self.cycleView2];
    [self.view addSubview:self.pageControl2];
    
    [self.cycleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.cycleView1.mas_bottom).offset(50);
        make.height.mas_equalTo(150);
    }];
    
    [self.pageControl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.cycleView2.mas_bottom).offset(-20);
    }];
    
    //设置pageControl样式
    LXPageControlStyle *style2 = [LXPageControlStyle new];
    style2.positionType = LXPageControlPositionLeft;
    style2.itemSpacing = 10;
    style2.dotNormalSize = CGSizeMake(10, 10);
    style2.dotSelectedSize = CGSizeMake(10, 20);
    style2.dotSelectedColor = [UIColor greenColor];
    style2.cornerRadius = 5;
    self.pageControl2.style = style2;
    self.pageControl2.numberOfPages = self.images.count;
    
    //右边样式
    self.cycleView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:self.images];
    self.cycleView3.delegate = self;
    self.cycleView3.showPageControl = NO;
    
    self.pageControl3 = [[LXPageControl alloc] init];
    self.pageControl3.actionHandle = ^(NSInteger index) {
        [weakSelf.cycleView3 makeScrollViewScrollToIndex:index];
    };
    [self.view addSubview:self.cycleView3];
    [self.view addSubview:self.pageControl3];
    
    [self.cycleView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.cycleView2.mas_bottom).offset(50);
        make.height.mas_equalTo(150);
    }];
    
    [self.pageControl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.cycleView3.mas_bottom).offset(-20);
    }];
    
    //设置pageControl样式
    LXPageControlStyle *style3 = [LXPageControlStyle new];
    style3.positionType = LXPageControlPositionRight;
    style3.itemSpacing = 15;
    style3.dotNormalSize = CGSizeMake(10, 10);
    style3.dotSelectedSize = CGSizeMake(20, 10);
    style3.cornerRadius = 5;
    style3.dotSelectedColor = [UIColor redColor];
    self.pageControl3.style = style3;
    self.pageControl3.numberOfPages = self.images.count;
    
    //使用图片
    self.cycleView4 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:self.images];
    self.cycleView4.delegate = self;
    self.cycleView4.showPageControl = NO;
    
    self.pageControl4 = [[LXPageControl alloc] init];
    self.pageControl4.actionHandle = ^(NSInteger index) {
        [weakSelf.cycleView4 makeScrollViewScrollToIndex:index];
    };
    [self.view addSubview:self.cycleView4];
    [self.view addSubview:self.pageControl4];
    
    [self.cycleView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.cycleView3.mas_bottom).offset(50);
        make.height.mas_equalTo(150);
    }];
    
    [self.pageControl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.cycleView4.mas_bottom).offset(-20);
    }];
    
    //设置pageControl样式
    LXPageControlStyle *style4 = [LXPageControlStyle new];
    style4.itemSpacing = 20;
    style4.dotNormalSize = CGSizeMake(20, 20);
    style4.dotSelectedSize = CGSizeMake(20, 20);
    style4.cornerRadius = 0;
    style4.dotNormalColor = nil;
    style4.dotSelectedColor = nil;
    style4.normalImage = [UIImage imageNamed:@"1"];
    style4.selectedImage = [UIImage imageNamed:@"2"];
    self.pageControl4.style = style4;
    self.pageControl4.numberOfPages = self.images.count;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    if (cycleScrollView == self.cycleView1) {
        self.pageControl1.currentPage = index;
    }else if (cycleScrollView == self.cycleView2){
        self.pageControl2.currentPage = index;
    }else if (cycleScrollView == self.cycleView3){
        self.pageControl3.currentPage = index;
    }else if (cycleScrollView == self.cycleView4){
        self.pageControl4.currentPage = index;
    }
}
@end
