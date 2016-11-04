//
//  FWZoomCollectionView.m
//  HorizontalCollectionViewDemo
//
//  Created by 武建明 on 2016/11/4.
//  Copyright © 2016年 WJM. All rights reserved.
//

#import "FWZoomCollectionView.h"
#import "FWZoomCollectionViewFlowLayout.h"
/* 缩放倍数 */
#define ZC 1.10

@interface FWZoomCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,FWZoomCollectionViewFlowLayoutDelegate>

@property (strong, nonatomic)FWZoomCollectionViewFlowLayout *flowLayout;

@end

@implementation FWZoomCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame collectionViewLayout:self.flowLayout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark - Property
- (FWZoomCollectionViewFlowLayout *)flowLayout{

    if (!_flowLayout) {
        _flowLayout = [[FWZoomCollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection =UICollectionViewScrollDirectionHorizontal;
        _flowLayout.delegate = self;
        _flowLayout.zoomCoefficient = ZC;
    }
    return _flowLayout;
}
#pragma mark - SetUp
- (void)setMaxItemSize:(CGSize)maxItemSize{
    _maxItemSize = maxItemSize;
    self.flowLayout.itemSize = CGSizeMake(_maxItemSize.width, _maxItemSize.height/ZC);
    CGFloat oneX = (self.bounds.size.width -self.flowLayout.itemSize.width) *0.5;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, oneX, 0, oneX);
}
- (void)setMiniLineSpacing:(CGFloat)miniLineSpacing{
    _miniLineSpacing = miniLineSpacing;
    self.flowLayout.minimumLineSpacing = _miniLineSpacing/ZC;
}
- (void)setIsAlpha:(BOOL)isAlpha{
    _isAlpha = isAlpha;
    self.flowLayout.isAlpha = _isAlpha;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGPoint pInView = [self.superview convertPoint:collectionView.center toView:collectionView];
    // 获取中间cell的indexPath
    NSIndexPath *indexPathNow = [collectionView indexPathForItemAtPoint:pInView];
    //如果被点击处于中间则进入点击事件,否则,把被点击cell,滑动到中间
    if (indexPath.row == indexPathNow.row) {

        if (self.zDelegate && [self.zDelegate respondsToSelector:@selector(zoomCollectionView:didSelectItemAtIndex:)]) {
            [self.zDelegate zoomCollectionView:self didSelectItemAtIndex:indexPath.row];
        }
    }else{
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}
#pragma mark - UICollectionViewDataSource
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.zDatasource zoomCollectionView:self cellForItemAtIndexPath:indexPath cellForDataAtIndex:indexPath.row];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.zDatasource zoomCollectionView:self numberOfItemsInSection:section];
}
#pragma mark - WJMCollectionViewFlowLayoutDelegate
- (void)collectionViewDidScrollowTo:(NSInteger)index{
    if (self.zDelegate && [self.zDelegate respondsToSelector:@selector(zoomCollectionView:didScrollowTo:)]) {
        [self.zDelegate zoomCollectionView:self didScrollowTo:index];
    }
}

@end
