//
//  MyCommentFirstCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentFirstCollectionViewCell.h"

@interface MyCommentFirstCollectionViewCell()

/**
 *  预约类型，洗车/维修
 */
@property (nonatomic, weak) UILabel* contentLabel;
/**
 *  星星所在的view，设置可滑动
 */
@property (nonatomic, weak) UIView* baseView1;
/**
 *  所有星星数组
 */
@property (nonatomic, strong) NSMutableArray* allStarsArr;
/**
 *  选中的星星数，评分的分数
 */
@property (nonatomic, strong) NSString* starScore;
@end
@implementation MyCommentFirstCollectionViewCell

NSString * const MyCommentFirstCollectionViewCellId = @"MyCommentFirstCollectionViewCellId";

-(NSMutableArray *)allStarsArr
{
    if (!_allStarsArr)
    {
        _allStarsArr = [NSMutableArray array];
    }
    return _allStarsArr;
}


+(MyCommentFirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
    dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                              forIndexPath:(NSIndexPath *)indexPath
{
    MyCommentFirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UILabel* titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"预约类型：";
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:titleLabel];
        
        CGFloat titleLabelWidth = [titleLabel calculateWidthWithLabelContent:titleLabel.text
                                                              WithFontName:nil
                                                              WithFontSize:14
                                                                  WithBold:YES];
        
        UILabel* scoreLabel = [[UILabel alloc]init];
        scoreLabel.text = @"评分：";
        scoreLabel.font = [UIFont boldSystemFontOfSize:14];
        scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:scoreLabel];
        
        CGFloat scoreLabelWidth = [scoreLabel calculateWidthWithLabelContent:scoreLabel.text
                                                                WithFontName:nil
                                                                WithFontSize:14
                                                                    WithBold:YES];
        
        UIView *baseView1 = [[UIView alloc]init];
//        baseView1.backgroundColor = [UIColor redColor];
        baseView1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseView1];
        self.baseView1 = baseView1;
        
        UIImageView* starImageView;
        for (NSInteger i=0; i<5; i++)
        {
            starImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_star")];
            
            starImageView.frame = CGRectMake(self.baseView1.bounds.origin.x+(1+i)*13, self.baseView1.bounds.origin.y, 13, 13);
            [baseView1 addSubview:starImageView];
            [self.allStarsArr addObject:starImageView];
            
        }
        
        
        
        UILabel* contentLabel = [[UILabel alloc]init];
        
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = UIColorFromRGB(0x929292);
        contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        titleLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.03).topSpaceToView(self,ScreenHeight*0.024).widthIs(titleLabelWidth).autoHeightRatio(0);
        contentLabel.sd_layout.leftSpaceToView(titleLabel,10).topEqualToView(titleLabel).rightEqualToView(self).autoHeightRatio(0);
        scoreLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(titleLabel,ScreenHeight*0.03).widthIs(scoreLabelWidth).autoHeightRatio(0);
        baseView1.sd_layout.centerYEqualToView(scoreLabel).leftSpaceToView(scoreLabel,10).topEqualToView(scoreLabel).bottomEqualToView(scoreLabel).rightEqualToView(self);
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        self.contentLabel.text = (NSString*)object;
    }
    
}


#pragma mark - 评论星星选择，点击的坐标
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.baseView1];
    UIImageView *im ;
    for(int i = 0;i < 5 ; i++)
    {
        im = self.allStarsArr[i];
        NSLog(@"_all[%i] = (%f,%f)",i,im.frame.origin.x,im.frame.origin.y);
        if ((touchPoint.x > 0)&&(touchPoint.x < 144)&&(touchPoint.y > 0)&&(touchPoint.y < 13))
        {
            self.starScore = [NSString stringWithFormat:@"%i",((int)touchPoint.x)/13];
            //            _score.text = myscore;//_score是一个UILable，myscore为分数，显示在给用户看，关于这个不在赘述
            if (im.frame.origin.x > touchPoint.x)
            {
                im.image =[UIImage imageNamed:@"order_star1"];
            }
            else
            {
                im.image =[UIImage imageNamed:@"order_star"];
            }
        }
    }
    [self sendNotification];//把分数传控制器
}
#pragma mark - 评论星星选择，滑动的坐标
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.baseView1];
    UIImageView *im ;
    for(int i = 0;i < 5 ; i++)
    {
        im = self.allStarsArr[i];
        NSLog(@"_all[%i] = (%f,%f)",i,im.frame.origin.x,im.frame.origin.y);
        if ((touchPoint.x > 0)&&(touchPoint.x < 144)&&(touchPoint.y > 0)&&(touchPoint.y < 13))
        {
            self.starScore = [NSString stringWithFormat:@"%i",((int)touchPoint.x)/13];
            //            _score.text = myscore;//_score是一个UILable，myscore为分数，显示在给用户看，关于这个不在赘述
            if (im.frame.origin.x > touchPoint.x)
            {
                im.image =[UIImage imageNamed:@"order_star1"];
            }
            else
            {
                im.image =[UIImage imageNamed:@"order_star"];
            }
        }
    }
    [self sendNotification];//把分数传控制器
}

-(void)sendNotification
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_comment_StarScore object:nil userInfo:@{@"score":self.starScore}];
}
@end
