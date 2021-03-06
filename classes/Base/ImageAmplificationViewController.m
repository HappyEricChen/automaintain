//
//  ImageAmplificationViewController.m
//  automaintain
//
//  Created by eric on 16/7/6.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ImageAmplificationViewController.h"

@interface ImageAmplificationViewController ()<UIScrollViewDelegate>

/**
 *  图片
 */
@property (nonatomic, weak) UIImageView* imageView;
/**
 *  捏合手势放大缩小用
 */
@property (nonatomic, weak) UIScrollView* scrollView;
/**
 *  双击，放大或者缩小
 */
@property (nonatomic, getter=isBigImage) BOOL bigImage;

@end

@implementation ImageAmplificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self configureImageView];
}

-(void)configureImageView
{
    UIImageView* imageView = [[UIImageView alloc]init];
    
    [imageView setImageWithURL:[NSURL URLWithString:self.imageUrl]
                   placeholder:ImageNamed(@"personal_img0")
                       options:YYWebImageOptionProgressiveBlur
                    completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error)
     {
         
     }];
    
    imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
    
    /**
     添加单机手势，点击返回
         */
        UITapGestureRecognizer* singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        imageView.userInteractionEnabled = YES;
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        [imageView addGestureRecognizer:singleTapGestureRecognizer];
        /**
         *  添加双击手势，双击方法缩小
         */
        UITapGestureRecognizer* doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [imageView addGestureRecognizer:doubleTapGestureRecognizer];
    
//    这行很关键，意思是只有当没有检测到doubleTapGestureRecognizer 或者 检测doubleTapGestureRecognizer失败，singleTapGestureRecognizer才有效
        [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    
    
    
    self.imageView = imageView;
    
    if (self.scrollView==nil)
    {
        UIScrollView *scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenHeight*0.2, ScreenWidth, ScreenHeight*0.5)];
        [scrollView addSubview:imageView];
        scrollView.delegate=self;
        scrollView.contentSize = self.imageView.size;
        scrollView.alwaysBounceHorizontal = YES;//水平方向总能滑动
        scrollView.maximumZoomScale=2;
        scrollView.minimumZoomScale=1;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        self.scrollView=scrollView;
        [self.view addSubview:scrollView];
    }
    
}

-(void)singleTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)doubleTap:(UIGestureRecognizer*)gestureRecognizer
{
    if (!self.isBigImage)
    {
        [UIView animateWithDuration:0.2 animations:^{          //放大frame
            self.scrollView.frame = CGRectMake(0, ScreenHeight*0.2, ScreenWidth, ScreenHeight*0.5);
            self.imageView.frame=CGRectMake(0, 0, self.imageView.size.width*2, self.imageView.size.height*2);
            
            self.scrollView.contentSize=self.imageView.size;
            self.scrollView.alwaysBounceVertical = YES;
            self.scrollView.scrollEnabled = YES;
        }completion:^(BOOL finished) {
            
        }];
        
        self.bigImage = YES;
        
    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.frame=CGRectMake(0, ScreenHeight*0.2, ScreenWidth, ScreenHeight*0.5);
            self.imageView.frame=CGRectMake(0, 0, ScreenWidth, ScreenWidth);
            self.scrollView.contentSize=self.imageView.size;
        } completion:^(BOOL finished) {
            
        }];
        
        self.bigImage = NO;
    }
}

#pragma mark - UIScrollViewDelegate缩放图片
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
