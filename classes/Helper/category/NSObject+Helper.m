//
//  NSObject+Helper.m
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)

-(CGSize)calculateSizeWithLabelContent:(NSString *)labelContent
                          WithFontName:(NSString *)fontName
                          WithFontSize:(CGFloat)fontSize
{
    UIFont* font = nil;
    if (fontName)
    {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    else
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    UILabel* label = [[UILabel alloc]init];
    label.text = labelContent;
    label.font = font;
    label.numberOfLines = 0;
    CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size;
}

-(CGFloat)calculateWidthWithLabelContent:(NSString *)labelContent
                           WithFontName:(NSString *)fontName
                           WithFontSize:(CGFloat)fontSize
                                WithBold:(BOOL)isBold
{
    UIFont* font = nil;
    if (fontName)
    {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    else
    {
        if (isBold)
        {
            font = [UIFont boldSystemFontOfSize:fontSize];
        }
        else
        {
            font = [UIFont systemFontOfSize:fontSize];
        }
        
    }
    UILabel* label = [[UILabel alloc]init];
    label.text = labelContent;
    label.font = font;
    CGSize size = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    
    return size.width;
}
#pragma mark - 根据宽度计算高度
-(CGFloat)calculateHeighWithLabelContent:(NSString *)labelContent
                            WithFontName:(NSString *)fontName
                            WithFontSize:(CGFloat)fontSize
                               WithWidth:(CGFloat)width
                                WithBold:(BOOL)isBold
{
    UIFont* font = nil;
    if (fontName)
    {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
    else
    {
        font = [UIFont systemFontOfSize:fontSize];
    }
    UILabel* label = [[UILabel alloc]init];
    label.text = labelContent;
    label.font = font;
    label.numberOfLines = 0;
    
    CGRect tmpRect = [label.text boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    CGSize size = tmpRect.size;
    return size.height;
    
}
@end
