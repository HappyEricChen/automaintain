//
//  NSObject+Helper.h
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)


/**
 *  根据文字的大小,数量计算宽度,返回size
 */
-(CGSize)calculateSizeWithLabelContent:(NSString*)labelContent WithFontName:(NSString*)fontName WithFontSize:(CGFloat)fontSize;

/**
 *  根据文字的大小,数量计算宽度,返回width
 */
-(CGFloat)calculateWidthWithLabelContent:(NSString*)labelContent
                            WithFontName:(NSString*)fontName
                            WithFontSize:(CGFloat)fontSize
                                WithBold:(BOOL)isBold;
@end
