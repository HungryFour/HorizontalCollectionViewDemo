//
//  WJMCollectionViewFlowLayout.m
//  HorizontalCollectionView
//
//  Created by WJM on 16/3/10.
//  Copyright © 2016年 WJM. All rights reserved.
//

#import "WJMCollectionViewFlowLayout.h"
#define zoomScale (1.08-1)

@implementation WJMCollectionViewFlowLayout

//第一个
- (void)prepareLayout
{
    [super prepareLayout];
}

//第三个
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    //1.确定加载item的区域
    CGFloat  x =self.collectionView.contentOffset.x;
    CGFloat  y =0;
    CGFloat  w =self.collectionView.frame.size.width;
    CGFloat  h = self.collectionView.frame.size.height;
    CGRect myrect =CGRectMake(x, y, w, h);
    
    //2.获得这个区域的item
    NSArray *original =[super layoutAttributesForElementsInRect:myrect];
    
    //遍历item,快到中间的时候放大，离开中间的时候收索
    for (UICollectionViewLayoutAttributes *atts in original) {
        //1.获得item距离左边的边框的距离
        CGFloat leftdelta =atts.center.x -self.collectionView.contentOffset.x;
        
        //2.获得屏幕的中心点
        CGFloat centerX =self.collectionView.frame.size.width *0.5;
        //3.获得距离中心的距离
        CGFloat dela =fabs(centerX -leftdelta);
        
        //4.左边的item缩小
        // CGFloat leftscale =dela/centerX;
        CGFloat rightscale =1.00-dela/centerX;
        
        //5.缩放
        atts.transform =CGAffineTransformMakeScale(1+rightscale *zoomScale  , 1+rightscale *zoomScale);
        
        CGFloat dela1 =fabs(leftdelta -centerX);
        CGFloat rightscale1 =1.00-dela1/centerX;

        if (rightscale1 < 0.5) {
            atts.alpha = 0.5;
        }else if(rightscale1 >0.99){
            atts.alpha = 1;
        }else{
            atts.alpha = rightscale1;
        }
        
    }
    NSArray * attributes = [[NSArray alloc] initWithArray:original copyItems:YES];

    return attributes;
}

//滚动的时候一直调用（相当于滚动间监听）
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    [super shouldInvalidateLayoutForBoundsChange:newBounds];
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //停止滚动的时候定位在中心
    //1.拿到区域内的cell
    //1.1.确定加载item的区域
    CGFloat  x =self.collectionView.contentOffset.x;
    CGFloat  y =0;
    CGFloat  w =self.collectionView.frame.size.width;
    CGFloat  h = self.collectionView.frame.size.height;
    CGRect myrect =CGRectMake(x, y, w, h);
    
    //1.2.获得这个区域的item
    NSArray *arr =[super layoutAttributesForElementsInRect:myrect];
    
    CGFloat mindelta =MAXFLOAT;
    for (UICollectionViewLayoutAttributes *atts in arr) {
        
        //2.计算距离中心点的距离
        //1.获得item距离左边的边框的距离
        CGFloat leftdelta =atts.center.x -proposedContentOffset.x;
        //2.获得屏幕的中心点
        CGFloat centerX =self.collectionView.frame.size.width *0.5;
        //3.获得距离中心的距离
        CGFloat dela = fabs(centerX -leftdelta);
        //4.获得最小的距离
        if(dela <= mindelta)
            mindelta = centerX -leftdelta;
    }

    //定位在中心，注意是-号，回到之前的位置
    proposedContentOffset.x -= mindelta;
    
    //防止在第一个和最后一个 滑到中间时  卡住
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    
    if (proposedContentOffset.x > (self.collectionView.contentSize.width-self.sectionInset.left-self.sectionInset.right-self.itemSize.width)) {
        
        proposedContentOffset.x = floor(proposedContentOffset.x);
    }
    
    return proposedContentOffset;
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}
@end
