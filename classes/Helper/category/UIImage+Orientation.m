//
//  UIImage+Orientation.m
//  一号车库
//
//  Created by eric on 16/8/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "UIImage+Orientation.h"

@implementation UIImage (Orientation)

- (UIImage *)normalizedImage
{
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

@end
