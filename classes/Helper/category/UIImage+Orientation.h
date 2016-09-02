//
//  UIImage+Orientation.h
//  一号车库
//
//  Created by eric on 16/8/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Orientation)

/**
 *  调整图片方向为正向
 */
- (UIImage *)normalizedImage;

//图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
