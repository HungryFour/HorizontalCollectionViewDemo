//
//  FWZoomCollectionViewFlowLayout.h
//  HorizontalCollectionViewDemo
//
//  Created by 武建明 on 2016/11/4.
//  Copyright © 2016年 WJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FWZoomCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectionViewDidScrollowTo:(NSInteger)index;

@end

@interface FWZoomCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<FWZoomCollectionViewFlowLayoutDelegate>delegate;

@property (assign, nonatomic) CGFloat zoomCoefficient;
///透明度是否打开 默认NO/不打开
@property (assign, nonatomic) BOOL isAlpha;

@end
