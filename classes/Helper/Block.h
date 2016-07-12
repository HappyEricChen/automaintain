//
//  Block.h
//  一号车库
//
//  Created by eric on 16/7/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#ifndef Block_h
#define Block_h

/**
 * callback function
 * @params success YES show opeartion success, NO show operation fail out of expect
 * @params error, default is nil, if params success is No, then return error object
 * @params result id type, default nil, if interface need return some objects then put then in the result.
 */
typedef void (^Callback)(BOOL success, NSError* error,id result);

#endif /* Block_h */
