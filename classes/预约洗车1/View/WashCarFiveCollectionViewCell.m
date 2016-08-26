//
//  WashCarFiveCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarFiveCollectionViewCell.h"
#import "UserCommentModel.h"
#import "CommentImageCollectionView.h"

@interface WashCarFiveCollectionViewCell()<CommentImageCollectionViewDelegate>
/**
 *  评论的图片 按钮
 */
@property (nonatomic, weak) UIButton* imageButton;

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
 *  评论图片所在的底部View
 */
@property (nonatomic, weak) CommentImageCollectionView* commentImageCollectionView;
/**
 *  评论的项目类型
 */
@property (nonatomic, weak) UILabel* projectType;
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
         头像／用户名／星星／时间///基础的View
         */
        UIView* baseView = [[UIView alloc]init];
        [self addSubview:baseView];
        /**
         头像
         */
        UIImageView* iconImageView = [[YYAnimatedImageView alloc]init];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 26*0.5;//宽度的一半为圆形
        
        [baseView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        /**
         用户名
         */
        UILabel* userName = [[UILabel alloc]init];
        userName.font = [UIFont systemFontOfSize:11];
        userName.textColor = UIColorFromRGB(0x4a4a4a);
        userName.textAlignment = NSTextAlignmentLeft;
        [baseView addSubview:userName];
        self.userName = userName;
        
        
        /**
         项目类型名字
         */
        UILabel* projectType = [[UILabel alloc]init];
        projectType.font = [UIFont systemFontOfSize:11];
        projectType.textColor = UIColorFromRGB(0x4a4a4a);
        projectType.textAlignment = NSTextAlignmentLeft;
        [self addSubview:projectType];
        self.projectType = projectType;
        
        /**
         星星底部的View
         */
        UIView *baseView1 = [[UIView alloc]init];
        [baseView addSubview:baseView1];
        
        for (NSInteger i=0; i<5; i++)
        {
            UIImageView* starImageView = [[YYAnimatedImageView alloc]init];
            starImageView.frame = CGRectMake(5+13*i, 6, 13, 13);
            [self.starImageViewArr addObject:starImageView];
            [baseView1 addSubview:starImageView];
            
        }
        /**
         时间
         */
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.font = [UIFont systemFontOfSize:11];
        [baseView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        
        /**
         *  评论内容
         */
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont systemFontOfSize:11];
        contentLabel.textColor = UIColorFromRGB(0x4a4a4a);
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;

        /**
         评论图片显示的View
         */
        CommentImageCollectionView* commentImageCollectionView = [[CommentImageCollectionView alloc]init];
        [self addSubview:commentImageCollectionView];
        commentImageCollectionView.delegate = self;
        self.commentImageCollectionView = commentImageCollectionView;
        

        
        baseView.sd_layout.leftSpaceToView(self,10).rightEqualToView(self).topEqualToView(self).heightIs(ScreenHeight*0.03);
        iconImageView.sd_layout.leftEqualToView(baseView).topEqualToView(baseView).widthIs(26).heightIs(26);
        
        baseView1.sd_layout.centerYEqualToView(userName).leftSpaceToView(userName,ScreenWidth*0.026).heightRatioToView(userName,1).widthIs(ScreenWidth*0.26);
        timeLabel.sd_layout.centerYEqualToView(userName).rightEqualToView(baseView).topEqualToView(userName).bottomEqualToView(userName).widthIs(ScreenWidth*0.24);
        projectType.sd_layout.leftSpaceToView(self,26+ScreenWidth*0.026+10).topSpaceToView(baseView,10).rightSpaceToView(self,10).autoHeightRatio(0);
        contentLabel.sd_layout.leftEqualToView(projectType).topSpaceToView(projectType,13).rightSpaceToView(self,10).autoHeightRatio(0);
        commentImageCollectionView.sd_layout.leftEqualToView(contentLabel).topSpaceToView(contentLabel,10).bottomEqualToView(self).rightSpaceToView(self,10);
        
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    UserCommentModel* userCommentModel = (UserCommentModel*)object;
    self.contentLabel.text = userCommentModel.CommentContent;
    self.timeLabel.text = [userCommentModel.CreateTime substringToIndex:10];
    self.projectType.text = [NSString stringWithFormat:@"服务项目：%@",userCommentModel.MaintainSubjectName];
    
    NSString* iconImageUrlStr = userCommentModel.AvatarUrl;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:iconImageUrlStr]
                          placeholderImage:ImageNamed(@"order_user")
                                   options:SDWebImageRetryFailed | SDWebImageLowPriority
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
     {
        
    }];
    
    
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
            /**
             *  要保留，每个状态都要有值，防止复用异常
             */
            imageView.image = ImageNamed(@"order_star1");
        }
        
    }
    
    /**
     *  评论图片
     */
    
    if (userCommentModel.PhotoUrls.count == 0)
    {
        self.commentImageCollectionView.hidden = YES;
    }
    else
    {
        self.commentImageCollectionView.userCommentModel = userCommentModel;
        self.commentImageCollectionView.hidden = NO;
    }
}


-(NSMutableArray *)starImageViewArr
{
    if (!_starImageViewArr)
    {
        _starImageViewArr = [NSMutableArray array];
    }
    return _starImageViewArr;
}


#pragma mark - 点击评论图片调用的方法
-(void)didClickCommentImageWithCommentImageCollectionView:(CommentImageCollectionView *)commentImageCollectionView withImageUrl:(NSString *)imageUrl
{
    if ([self.delegate respondsToSelector:@selector(didClickCarImageWithWashCarFiveCollectionViewCell:withImageUrl:)])
    {
        [self.delegate didClickCarImageWithWashCarFiveCollectionViewCell:self withImageUrl:imageUrl];
    }
}

@end
