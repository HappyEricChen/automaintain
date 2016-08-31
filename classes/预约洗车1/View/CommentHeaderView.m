//
//  CommentHeaderView.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView()
/**
 *  用户评价(288条)
 */
@property (nonatomic, weak) UILabel* label;
@end
@implementation CommentHeaderView

NSString* const headerId = @"headerId";

+(CommentHeaderView *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    CommentHeaderView* cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         用户评价（文字）
         */
        UILabel* label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:11];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        self.label = label;
        label.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).topEqualToView(self).bottomEqualToView(self).widthIs(ScreenWidth*0.5);
    }
    return self;
}

-(void)layoutWithObject:(NSInteger)object
{
    if (object == 0)
    {
        self.label.text = @"用户评价";
    }
    else
    {
        self.label.text = [NSString stringWithFormat:@"用户评价(%ld条)",object];
    }
    
}
@end
