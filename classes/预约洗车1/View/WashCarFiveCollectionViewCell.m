//
//  WashCarFiveCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarFiveCollectionViewCell.h"
#import "UserCommentModel.h"
@interface WashCarFiveCollectionViewCell()

@property (nonatomic, weak) UIImageView* carImageView;

@property (nonatomic, getter=isClick) BOOL click;
/**
 *  评论内容
 */
@property (nonatomic, weak) UILabel* contentLabel;
/**
 *  评论发布时间
 */
@property (nonatomic, weak) UILabel* timeLabel;
/**
 *  用户名
 */
@property (nonatomic, weak) UILabel* userName;
/**
 *  用户头像
 */
@property (nonatomic, weak) UIImageView* iconImageView;

/**
 *   评论星星数组
 */
@property (nonatomic, strong) NSMutableArray* starImageViewArr;
/**
 *   评论图片url数组
 */
@property (nonatomic, strong) NSMutableArray* photoImageViewArr;
@end
@implementation WashCarFiveCollectionViewCell

NSString* const WashCarFiveCollectionViewCellId = @"WashCarFiveCollectionViewCellId";

CGFloat userNameWidth;

+(WashCarFiveCollectionViewCell *)collectionView:(UICollectionView *)collectionView
          dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                    forIndexPath:(NSIndexPath *)indexPath
{
    WashCarFiveCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                    forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         头像／用户名／星星／时间
         */
        UIView* baseView = [[UIView alloc]init];
        baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseView];
        
        UIImageView* iconImageView = [[UIImageView alloc]init];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel* userName = [[UILabel alloc]init];
        userName.font = [UIFont systemFontOfSize:11];
        userName.textColor = UIColorFromRGB(0x4a4a4a);
        userName.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:userName];
        self.userName = userName;
        
        
        UIView *baseView1 = [[UIView alloc]init];
        baseView1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:baseView1];
        
        for (NSInteger i=0; i<5; i++)
        {
            UIImageView* starImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_star1")];
            starImageView.frame = CGRectMake(5+13*i, 6, 13, 13);
            [self.starImageViewArr addObject:starImageView];
            [baseView1 addSubview:starImageView];
            
        }
        
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:11];
        timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        
        /**
         *  评论内容
         */
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont systemFontOfSize:11];
        contentLabel.textColor = UIColorFromRGB(0x4a4a4a);
        contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;

        UIView * carView = [[UIView alloc]init];
        carView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:carView];
        
        for (NSInteger i=0; i<3; i++)
        {
            UIImageView* carImageView = [[UIImageView alloc]init];
            carImageView.frame = CGRectMake((12+70)*i, 0, ScreenWidth*0.189, ScreenHeight*0.073);
            [self.photoImageViewArr addObject:carImageView];
            [carView addSubview:carImageView];
            
            self.carImageView = carImageView;
        }
        
        baseView.sd_layout.leftSpaceToView(self,10).rightEqualToView(self).topEqualToView(self).heightIs(ScreenHeight*0.03);
        iconImageView.sd_layout.leftEqualToView(baseView).topEqualToView(baseView).widthIs(26).heightIs(26);
        
        baseView1.sd_layout.centerYEqualToView(userName).leftSpaceToView(userName,ScreenWidth*0.026).heightRatioToView(userName,1).widthIs(ScreenWidth*0.26);
        timeLabel.sd_layout.centerYEqualToView(userName).rightEqualToView(baseView).topEqualToView(userName).bottomEqualToView(userName).widthIs(ScreenWidth*0.24);
        contentLabel.sd_layout.leftSpaceToView(iconImageView,ScreenWidth*0.026).topSpaceToView(baseView,13).rightSpaceToView(self,10).autoHeightRatio(0);
        carView.sd_layout.leftSpaceToView(iconImageView,ScreenWidth*0.026).topSpaceToView(contentLabel,10).bottomEqualToView(self).rightSpaceToView(self,10);
        
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    UserCommentModel* userCommentModel = (UserCommentModel*)object;
     self.contentLabel.text = userCommentModel.CommentContent;
    self.timeLabel.text = [userCommentModel.CreateTime substringToIndex:10];
    NSString* iconImageUrlStr = userCommentModel.AvatarUrl;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconImageUrlStr] placeholderImage:ImageNamed(@"order_user")];
    /**
     *  根据名字长度布局
     */
    self.userName.text = userCommentModel.Name;
    userNameWidth = [self.userName calculateWidthWithLabelContent:self.userName.text
                                                WithFontName:nil
                                                WithFontSize:11
                                                    WithBold:NO];
    self.userName.sd_layout.centerYEqualToView(self.iconImageView).leftSpaceToView(self.iconImageView,ScreenWidth*0.026).widthIs(userNameWidth).topEqualToView(self.iconImageView).bottomEqualToView(self.iconImageView);
    
    /**
     *  星星数量展示
     */
    NSInteger starsCount = userCommentModel.Stars.integerValue;
    
    for (NSInteger i=0; i<self.starImageViewArr.count; i++)
    {
        UIImageView* imageView = self.starImageViewArr[i];
        if (i<starsCount)
        {
            imageView.image = ImageNamed(@"order_star");
        }
        else
        {
            imageView.image = ImageNamed(@"order_star1");
        }
        
    }
    
    /**
     *  评论图片
     */
    NSArray* photoUrlsArr = userCommentModel.PhotoUrls;
    for (NSInteger i=0; i<self.photoImageViewArr.count; i++)
    {
        UIImageView* imageView = self.photoImageViewArr[i];
        if (i<photoUrlsArr.count)
        {
            NSString* imageUrlStr = photoUrlsArr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:ImageNamed(@"home_icon_cleancar")];
        }
        else
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:ImageNamed(@"home_icon_cleancar")];
        }
        
    }
    
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction)];
    [recognizer setNumberOfTapsRequired:1];
    self.carImageView.userInteractionEnabled = YES;
    [self.carImageView addGestureRecognizer:recognizer];
    
}


-(NSMutableArray *)starImageViewArr
{
    if (!_starImageViewArr)
    {
        _starImageViewArr = [NSMutableArray array];
    }
    return _starImageViewArr;
}
-(NSMutableArray *)photoImageViewArr
{
    if (!_photoImageViewArr)
    {
        _photoImageViewArr = [NSMutableArray array];
    }
    return _photoImageViewArr;
}

-(void)tapImageAction
{
    
    if ([self.delegate respondsToSelector:@selector(didClickCarImageWithWashCarFiveCollectionViewCell:withImageView:)])
    {
        [self.delegate didClickCarImageWithWashCarFiveCollectionViewCell:self withImageView:self.carImageView];
    }
    
}

@end
