//
//  BaseCollectionViewFlowLayout.h
//  一号车库
//
//  Created by eric on 16/7/13.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseCollectionViewFlowLayout;

@protocol  BaseCollectionViewFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>

@end

@interface BaseCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<BaseCollectionViewFlowLayoutDelegate> delegate;

@end
