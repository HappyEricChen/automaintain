//
//  Header.h
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
// 宏定义

/**
 * 宏定义颜色，使用16进制表示
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alp]

/**
 *  图片加载方法
 */
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

/**
 * 屏幕宽度
 */
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

/**
 * 屏幕高度
 */
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

/**
 *  我的留言最大字数限制
 */
#define MAX_LIMIT_NUMS 100
/**
 *  我的评论最大字数限制
 */
#define MAX_COMMENT_LIMIT_NUMS 150

/**
 *  字体定义
 */
#define FONT_Aparajita(s) [UIFont fontWithName:@"Aparajita" size:s]
#define FONT_FZZYJW(s) [UIFont fontWithName:@"FZZYJW--GB1-0" size:s]

#define SubjectGuidWashCar @"00000000-0000-0000-0000-000000000001"

/**
 *  预约评论，每次请求5条
 */
#define COMMENT_PAGE_SIZE @"10"
/**
 *  在线留言，每次请求10条
 */
#define MESSAGE_PAGE_SIZE @"10"