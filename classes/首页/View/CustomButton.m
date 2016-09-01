//
//  CustomButton.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithImage:(UIImage *)image WithTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:imageView];
        
        UILabel* titleLabel = [[UILabel alloc]init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:titleLabel];
        
        imageView.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightIs(50);
        titleLabel.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(imageView,7).autoHeightRatio(0);
        
    }
    return self;
}

@end
