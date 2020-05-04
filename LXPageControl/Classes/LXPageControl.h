//
//  LXPageControl.h
//  LXNewHouse
//
//  Created by LOUXUN-K on 2020/2/26.
//  Copyright © 2020 louxun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LXPageControlPositionType) {
    ///left
    LXPageControlPositionLeft,
    ///middle
    LXPageControlPositionCenter,
    ///right
    LXPageControlPositionRight
};

@interface LXPageControlStyle : NSObject

/** position default is center*/
@property(nonatomic, assign)LXPageControlPositionType positionType;

/**
 top left bottom right margin  default {0, 10, 0 ,10}
 */
@property (nonatomic, assign)UIEdgeInsets padingEdge;

/** dot normal size default is {6,6}*/
@property(nonatomic, assign)CGSize dotNormalSize;

/** dot selected size default is {6,6}*/
@property(nonatomic, assign)CGSize dotSelectedSize;

/** dot normal size default is gray*/
@property(nonatomic, strong)UIColor *dotNormalColor;

/** dot selected size default is yellow*/
@property(nonatomic, strong)UIColor *dotSelectedColor;

/** dot space default is 6*/
@property(nonatomic, assign) CGFloat itemSpacing;

/** normal image*/
@property(nonatomic, strong)UIImage *normalImage;

/** selected image*/
@property(nonatomic, strong)UIImage *selectedImage;

/** corner default 3*/
@property(nonatomic, assign)CGFloat cornerRadius;

/** border default 0*/
@property(nonatomic, assign)CGFloat borderWidth;

/** border color */
@property(nonatomic, strong)UIColor *borderColor;

/** init */
+(instancetype)defaultStyle;

@end


@interface LXPageControl : UIControl
/** style*/
@property(nonatomic, strong)LXPageControlStyle *style;

/** default is 0*/
@property(nonatomic, assign)NSInteger numberOfPages;

/** default is 0. value pinned to 0..numberOfPages-1*/
@property(nonatomic, assign)NSInteger currentPage;

/** action callback*/
@property(nonatomic, copy)void (^actionHandle)(NSInteger index);

@end


