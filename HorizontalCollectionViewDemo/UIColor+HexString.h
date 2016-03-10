//
//  UIColor+HexString.h
//  JKPlus
//
//  Created by WJM on 15/10/29.
//  Copyright © 2015年 WJM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

///颜色值16进制转化
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
