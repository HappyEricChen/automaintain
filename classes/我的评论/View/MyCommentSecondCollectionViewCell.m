
//
//  MyCommentSecondCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentSecondCollectionViewCell.h"

@interface MyCommentSecondCollectionViewCell()<UITextViewDelegate>

@property (nonatomic, weak) UITextView* textView;
@property (nonatomic, weak) UILabel* placeholderLabel;

/**
 *  选择相机图片的底层View
 */
@property (nonatomic, weak) UIView* baseView;
/**
 *  选择相机图片的按钮
 */
@property (nonatomic, weak) UIButton* cameraButton;

/**
 *  选择评论图片的张数统计，最多三张
 */
@property (nonatomic, assign) NSInteger imageCount;

/**
 *  当前布局的imageView
 */
@property (nonatomic, weak) UIImageView* imageView;
@end

@implementation MyCommentSecondCollectionViewCell


NSString * const MyCommentSecondCollectionViewCellId = @"MyCommentSecondCollectionViewCellId";

+(MyCommentSecondCollectionViewCell *)collectionView:(UICollectionView *)collectionView
             dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                       forIndexPath:(NSIndexPath *)indexPath
{
    MyCommentSecondCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                       forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.imageCount = 0;
        
        UITextView* textView = [[UITextView alloc]init];
        textView.backgroundColor = UIColorFromRGB(0xf1eee7);
        textView.layer.borderWidth = 1.0f;
        textView.layer.borderColor = UIColorFromRGB(0x000000).CGColor;
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        textView.delegate = self;
        [self addSubview:textView];
        self.textView = textView;
        
        UILabel* placeHolderLabel = [[UILabel alloc]init];
        placeHolderLabel.font = [UIFont systemFontOfSize:11];
        placeHolderLabel.textColor = UIColorFromRGB(0xc0c0c0);
        placeHolderLabel.text = @"写下服务体会，可以给其他小伙伴提供参考~";
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [textView addSubview:placeHolderLabel];
        self.placeholderLabel = placeHolderLabel;
        
        UILabel* lengthLimitationLabel = [[UILabel alloc]init];
        lengthLimitationLabel.font = [UIFont systemFontOfSize:11];
        lengthLimitationLabel.textColor = UIColorFromRGB(0xc0c0c0);
        lengthLimitationLabel.text = @"长度在1~150字中间";
        lengthLimitationLabel.textAlignment = NSTextAlignmentRight;
        lengthLimitationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:lengthLimitationLabel];
        
        UIView* baseView = [[UIView alloc]init];
        baseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseView];
        self.baseView = baseView;
        
        UIButton* cameraButton = [[UIButton alloc]init];
        [cameraButton setImage:ImageNamed(@"suggestion_photo") forState:UIControlStateNormal];
        cameraButton.frame = CGRectMake(0, ScreenHeight*0.022, 30, 30);
        [cameraButton addTarget:self action:@selector(didclickCameraButton:) forControlEvents:UIControlEventTouchUpInside];
        self.cameraButton = cameraButton;
        [baseView addSubview:cameraButton];
        
        textView.sd_layout.leftSpaceToView(self,ScreenWidth*0.029).rightSpaceToView(self,ScreenWidth*0.029).topEqualToView(self).heightIs(ScreenHeight*0.121);
        placeHolderLabel.sd_layout.leftSpaceToView(textView,ScreenWidth*0.029).topSpaceToView(textView,ScreenWidth*0.029).rightEqualToView(textView).autoHeightRatio(0);
        lengthLimitationLabel.sd_layout.rightEqualToView(textView).topSpaceToView(textView,ScreenHeight*0.018).leftEqualToView(textView).autoHeightRatio(0);
        baseView.sd_layout.leftEqualToView(textView).bottomEqualToView(self).rightEqualToView(textView).topSpaceToView(lengthLimitationLabel,0);
        
    }
    return self;
}

#pragma mark -UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    if ([self.textView.text isEqualToString:@""])
    {
        self.placeholderLabel.hidden = NO;
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_COMMENT_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_COMMENT_LIMIT_NUMS];
        
        [textView setText:s];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_comment_Content object:nil userInfo:@{@"textViewContent":nsTextContent}];
    
    //不让显示负数
//    self.wordsCountLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,existTextNum),MAX_COMMENT_LIMIT_NUMS];
}
/**
 *  中文联想字不会触发
 */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        
        if (offsetRange.location < MAX_COMMENT_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_COMMENT_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = @"";
            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            if (asc) {
                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            }
            else
            {
                __block NSInteger idx = 0;
                __block NSString  *trimString = @"";//截取出的字串
                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                         options:NSStringEnumerationByComposedCharacterSequences
                                      usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                          
                                          NSInteger steplen = substring.length;
                                          if (idx >= rg.length) {
                                              *stop = YES; //取出所需要就break，提高效率
                                              return ;
                                          }
                                          
                                          trimString = [trimString stringByAppendingString:substring];
                                          
                                          idx = idx + steplen;//这里变化了，使用了字串占的长度来作为步长
                                      }];
                
                
                s = trimString;
            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            //既然是超出部分截取了，哪一定是最大限制了。
//            self.wordsCountLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_COMMENT_LIMIT_NUMS];
        }
        return NO;
    }
    
}

-(void)didclickCameraButton:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedCameraWithMyCommentSecondCollectionViewCell:)])
    {
        [self.delegate didSelectedCameraWithMyCommentSecondCollectionViewCell:self];
    }
    
}
-(void)layoutWithObject:(id)object
{
    if (object && [object isKindOfClass:[UIImage class]])
    {
        if(self.imageCount<3)
        {
            UIImageView* imageView = [[UIImageView alloc]init];
            imageView.backgroundColor = [UIColor greenColor];
            imageView.frame = CGRectMake(ScreenWidth*0.226*self.imageCount, 0, ScreenWidth*0.197, ScreenHeight*0.073);
            imageView.centerY_sd = self.cameraButton.centerY_sd;
            imageView.image = (UIImage*)object;
            imageView.userInteractionEnabled = YES;
            [self.baseView addSubview:imageView];
            self.imageView = imageView;
            UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc]init];
            [recognizer addTarget:self action:@selector(didClickImageView:)];
            [imageView addGestureRecognizer:recognizer];
            
            self.imageCount+= 1;
            
            if (self.imageCount ==3)
            {
                self.cameraButton.hidden = YES;
            }
            
        }
        
        CGRect myFrame = self.cameraButton.frame;
        myFrame.origin.x+=ScreenWidth*0.226;
        self.cameraButton.frame = myFrame;

    }
}

-(void)didClickImageView:(UIImageView*)imageView
{
    if ([self.delegate respondsToSelector:@selector(didClickImageViewWithMyCommentSecondCollectionViewCell:withImage:)])
    {
        [self.delegate didClickImageViewWithMyCommentSecondCollectionViewCell:self withImage:self.imageView.image];
    }
}
@end
