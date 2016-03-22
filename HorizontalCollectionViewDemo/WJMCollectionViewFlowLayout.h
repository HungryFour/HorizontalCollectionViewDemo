//
//  WJMCollectionViewFlowLayout.h
//  HorizontalCollectionView
//
//  Created by WJM on 16/3/10.
//  Copyright © 2016年 WJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WJMCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectionViewDidScrollowTo:(NSInteger)index;

@end

@interface WJMCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<WJMCollectionViewFlowLayoutDelegate>delegate;

///透明度是否打开 默认NO/不打开
@property (assign, nonatomic) BOOL isAlpha;

@end
