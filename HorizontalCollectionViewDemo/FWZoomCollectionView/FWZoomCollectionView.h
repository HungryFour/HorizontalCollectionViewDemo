//
//  FWZoomCollectionView.h
//  HorizontalCollectionViewDemo
//
//  Created by 武建明 on 2016/11/4.
//  Copyright © 2016年 WJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FWZoomCollectionView;

@protocol FWZoomCollectionViewDatasource <NSObject>

@required

- (NSInteger)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView numberOfItemsInSection:(NSInteger)section;

-(UICollectionViewCell *)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath cellForDataAtIndex:(NSInteger)index;

@end

@protocol FWZoomCollectionViewDelegate <NSObject>

- (void)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView didSelectItemAtIndex:(NSInteger)index;

- (void)zoomCollectionView:(FWZoomCollectionView *)zoomCollectionView didScrollowTo:(NSInteger)index;

@end


@interface FWZoomCollectionView : UICollectionView

@property (weak,nonatomic)id<FWZoomCollectionViewDatasource>zDatasource;

@property (weak,nonatomic)id<FWZoomCollectionViewDelegate>zDelegate;

/**
 中间item的尺寸
 */
@property (assign,nonatomic)CGSize maxItemSize;

/**
 两个item之间的间隔
 */
@property (assign,nonatomic)CGFloat miniLineSpacing;


/**
 透明度是否打开(item变小时,添加模糊效果) 默认NO/不打开
 */
@property (assign, nonatomic) BOOL isAlpha;
@end
