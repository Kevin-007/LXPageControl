//
//  LXPageControl.m
//  LXNewHouse
//
//  Created by LOUXUN-K on 2020/2/26.
//  Copyright © 2020 louxun. All rights reserved.
//

#import "LXPageControl.h"

#import <Masonry/Masonry.h>

@implementation LXPageControlStyle

+ (instancetype)defaultStyle
{
    LXPageControlStyle *style = [[LXPageControlStyle alloc] init];
    return style;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDefault];
    }
    return self;
}

- (void)setupDefault
{
    _positionType = LXPageControlPositionCenter;
    _padingEdge = UIEdgeInsetsMake(0, 10, 0, 10);
    _dotNormalSize = CGSizeMake(6, 6);
    _dotSelectedSize = CGSizeMake(6, 6);
    _itemSpacing = 6;
    _cornerRadius = 3;
    _dotNormalColor = [UIColor grayColor];
    _dotSelectedColor = [UIColor yellowColor];
    
}

@end

@interface LXPageControl ()

/** image view collections*/
@property(nonatomic, strong)NSArray<UIImageView *> *dotViewsArray;

/** containView*/
@property(nonatomic, strong)UIView *containView;
@end

@implementation LXPageControl

-(void)setupUI
{
    //clear
    [self clearSubViews];
    
    self.backgroundColor = [UIColor clearColor];
    
    if (!_numberOfPages) return;
    if (!_style) _style = [LXPageControlStyle defaultStyle];
    
    [self addSubview:self.containView];
    
    NSMutableArray *dotsViews = [NSMutableArray array];
    
    for (int i = 0; i < _numberOfPages; i++) {
        UIImageView *imgV = [self createImageView];
        if (_currentPage == i) {
            imgV.backgroundColor = _style.dotSelectedColor;
            imgV.image = _style.selectedImage;
        }else{
            imgV.backgroundColor = _style.dotNormalColor;
            imgV.image = _style.normalImage;
        }
        imgV.tag = i;
        
        [dotsViews addObject:imgV];
        
        imgV.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        [imgV addGestureRecognizer:tap];
        
        [self.containView addSubview:imgV];
    }
    
    _dotViewsArray = dotsViews;
    
    [self addLayout];
}

//create image view
- (UIImageView *)createImageView {
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.layer.cornerRadius = _style.cornerRadius;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    return imgView;
}

#pragma mark - layout subview
- (void)addLayout
{

    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (_style.positionType) {
            case LXPageControlPositionLeft:
                make.left.mas_equalTo(_style.padingEdge.left);
                break;
            case LXPageControlPositionCenter:
                make.centerX.mas_equalTo(0);
                break;
            case LXPageControlPositionRight:
                make.right.mas_equalTo(-_style.padingEdge.right);
                break;
        }
        make.bottom.mas_equalTo(-_style.padingEdge.bottom);
    }];
    
    [_dotViewsArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            
            CGFloat width = _style.dotNormalSize.width;
            CGFloat height = _style.dotNormalSize.height;
            if (_currentPage == idx) {
               width = _style.dotSelectedSize.width;
               height = _style.dotSelectedSize.height;
            }
            if (idx == 0) {
                make.left.mas_equalTo(0).priorityLow();
            }else{
                make.left.equalTo(_dotViewsArray[idx - 1].mas_right).offset(_style.itemSpacing).priorityLow();
            }
            
            if (idx == _dotViewsArray.count - 1) {
                make.right.mas_equalTo(0);
            }
            
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
           
        }];
    }];
}

#pragma mark - action
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIImageView *v = (UIImageView *)tap.view;
    self.currentPage = v.tag;
    !_actionHandle?:_actionHandle(v.tag);
}

#pragma mark - clear sub view
- (void)clearSubViews
{
    
    [self.containView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

#pragma mark - update layout
- (void)updateLayoutWithCurrentPage:(NSInteger)currentPage
{
    if (currentPage < _dotViewsArray.count) {
       UIImageView *originView = _dotViewsArray[_currentPage];
       UIImageView *targetView = _dotViewsArray[currentPage];
        [UIView animateWithDuration:0.25 animations:^{
            [originView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.style.dotNormalSize.width);
                make.height.mas_equalTo(self.style.dotNormalSize.height);
            }];
            [targetView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.style.dotSelectedSize.width);
                make.height.mas_equalTo(self.style.dotSelectedSize.height);
            }];
            
            targetView.backgroundColor = self.style.dotSelectedColor;
            targetView.image = self.style.selectedImage;
            
            originView.backgroundColor = self.style.dotNormalColor;
            originView.image = self.style.normalImage;
            
        }];
    }
}

#pragma mark - Setter & Getter
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self setupUI];
}

- (void)setStyle:(LXPageControlStyle *)style
{
    if (_style != style) {
        _style = style;
        [self setupUI];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (_currentPage != currentPage) {
        [self updateLayoutWithCurrentPage:currentPage];
        _currentPage =currentPage;
    }
}

- (UIView *)containView
{
    if (!_containView) {
        _containView = [[UIView alloc]init];
        _containView.backgroundColor = [UIColor clearColor];
    }
    return _containView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    return (view == self || view == self.containView)?nil:view; // self & event resign event
}
@end
