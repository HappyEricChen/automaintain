//
//  MyCommentThirdCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentThirdCollectionViewCell.h"

@interface MyCommentThirdCollectionViewCell()
/**
 *  选择的图片数组
 */
@property (nonatomic, strong) NSMutableArray* imageArr;
/**
 *  选择照片按钮
 */
@property (nonatomic, strong) UIButton* cameraButton;
/**
 *   删除照片按钮数组
 */
@property (nonatomic, strong) NSMutableArray* deleteButtonArr;
/**
 *   长按手势
 */
@property (nonatomic, strong) UILongPressGestureRecognizer* longPressRecognizer;
@end
@implementation MyCommentThirdCollectionViewCell

NSString * const MyCommentThirdCollectionViewCellId = @"MyCommentThirdCollectionViewCellId";

+(MyCommentThirdCollectionViewCell *)collectionView:(UICollectionView *)collectionView
              dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                        forIndexPath:(NSIndexPath *)indexPath
{
    MyCommentThirdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                        forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton* cameraButton = [[UIButton alloc]init];
        [cameraButton setImage:ImageNamed(@"suggestion_photo") forState:UIControlStateNormal];
        cameraButton.frame = CGRectMake(ScreenWidth*0.029, ScreenHeight*0.022, 30, 30);
        cameraButton.centerY = self.contentView.centerY;
        [cameraButton addTarget:self action:@selector(didclickCameraButton:) forControlEvents:UIControlEventTouchUpInside];
        self.cameraButton = cameraButton;
        [self.contentView addSubview:cameraButton];
        
    }
    return self;
}

-(NSMutableArray *)imageArr
{
    if (!_imageArr)
    {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

-(NSMutableArray *)deleteButtonArr
{
    if (!_deleteButtonArr)
    {
        _deleteButtonArr = [NSMutableArray array];
    }
    return _deleteButtonArr;
}

-(void)layoutWithObject:(id)object
{
    if (object && [object isKindOfClass:[UIImage class]])
    {
        if(self.imageArr.count<3)
        {
            UIImageView* imageView = [[UIImageView alloc]init];
            imageView.image = (UIImage*)object;
            imageView.userInteractionEnabled = YES;
            imageView.frame = CGRectMake(ScreenWidth*(0.27+0.029)*self.imageArr.count+11, 0, ScreenWidth*0.27, ScreenWidth*0.27);
            imageView.centerY = self.contentView.centerY;
            [self.contentView addSubview:imageView];
            [self.imageArr addObject:imageView];
            
            UIButton* deleteButton = [[UIButton alloc]init];
            [deleteButton setImage:ImageNamed(@"close") forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(clickDeleteImageButton:) forControlEvents:UIControlEventTouchUpInside];
            deleteButton.frame = CGRectMake(ScreenWidth*0.27-30, -2, 30, 30);
            deleteButton.hidden = YES;
            [self.deleteButtonArr addObject:deleteButton];
            [imageView addSubview:deleteButton];
            
            UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc]init];
            longPressRecognizer.minimumPressDuration = 1.0;
            [longPressRecognizer addTarget:self action:@selector(didClickImageView:)];
            [imageView addGestureRecognizer:longPressRecognizer];
            self.longPressRecognizer = longPressRecognizer;
            
            
            if (self.imageArr.count ==3)
            {
                self.cameraButton.hidden = YES;
            }
            else
            {
                self.cameraButton.hidden = NO;
            }
            
        }
        
        self.cameraButton.x += ScreenWidth*(0.27+0.029);
        
    }
}

#pragma mark - 长按图片调用，出现删除按钮
-(void)didClickImageView:(UITapGestureRecognizer*)imageViewGestureRecognizer
{
    /**
     ios7 后动画效果
     */
    [UIView animateWithDuration:1.0//动画时长
                          delay:0.0//动画延迟
         usingSpringWithDamping:0.0//弹簧效果0~1
          initialSpringVelocity:0.0//初始速度
                        options:UIViewAnimationOptionCurveEaseInOut//动画过渡效果
                     animations:^{
                         
                         for (UIButton* tempButton in self.deleteButtonArr)
                         {
                             tempButton.hidden = NO;
                         }
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - 点击删除照片按钮调用
-(void)clickDeleteImageButton:(UIButton*)sender
{
    UIImageView* imageView = (UIImageView*)sender.superview;
    [self.imageArr removeObject:imageView];
    [imageView removeFromSuperview];
    
    [UIView animateWithDuration:1.0//动画时长
                          delay:0.0//动画延迟
         usingSpringWithDamping:0.0//弹簧效果0~1
          initialSpringVelocity:0.0//初始速度
                        options:UIViewAnimationOptionCurveEaseInOut//动画过渡效果
                     animations:^{
                         
                         [self updateImageViewFrame];
                         self.cameraButton.hidden = NO;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
    if ([self.delegate respondsToSelector:@selector(didClickDeleteImageButtonWithMyCommentThirdCollectionViewCell:withImage:)])
    {
        [self.delegate didClickDeleteImageButtonWithMyCommentThirdCollectionViewCell:self withImage:imageView.image];
    }
    
}
/**
 *  点击选择照片按钮
 */
-(void)didclickCameraButton:(UIButton*)sender
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_cancel_Keyboard object:nil];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedCameraWithMyCommentThirdCollectionViewCell:)])
    {
        [self.delegate didSelectedCameraWithMyCommentThirdCollectionViewCell:self];
    }
    
}

/** 修改imageView的frame */
-(void)updateImageViewFrame
{
    for (int i = 0 ; i < self.imageArr.count; i++)
    {
        UIImageView *imageView = self.imageArr[i];
        if (i == 0)
        {
            imageView.x = 11;
        }
        else if (i == 1)
        {
            imageView.x = ScreenWidth*(0.27+0.029)+11;
        }
        else if(i == 2)
        {
            imageView.x = ScreenWidth*(0.27+0.029)*2+11;
        }
    }
    
    if (self.imageArr.count==1)
    {
        self.cameraButton.x = ScreenWidth*(0.27+0.029)+11;
    }
    else if (self.imageArr.count == 2)
    {
        self.cameraButton.x = ScreenWidth*(0.27+0.029)*2+11;
    }
    else if (self.imageArr.count==0)
    {
        self.cameraButton.x = ScreenWidth*0.029;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_cancel_Keyboard object:nil];
}
@end
