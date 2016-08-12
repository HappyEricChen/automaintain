//
//  OrderConfirmView.m
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderConfirmView.h"

@interface OrderConfirmView ()<UITextViewDelegate>

/**
 *  预约时间label
 */
@property (nonatomic, weak) UILabel* timeLabel;
/**
 *  预约项目label
 */
@property (nonatomic, weak) UILabel* projectLabel;
/**
 *  预计所需时间label
 */
@property (nonatomic, weak) UILabel* needTimeLabel;
/**
 *  项目价格
 */
@property (nonatomic, weak) UILabel* priceLabel;
/**
 *  留言label
 */
@property (nonatomic, weak) UILabel* leaveMessageLabel;
/**
 *  留言框
 */
@property (nonatomic, weak) UITextView* textView;
/**
 *  限制最多100个字
 */
@property (nonatomic, weak) UILabel* wordsCountLabel;
/**
 *  placeholder
 */
@property (nonatomic, weak) UILabel* placeholderLabel;

/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;

@end
@implementation OrderConfirmView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        /**
         *  预约时间
         */
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];
        /**
         *  预约项目
         */
        UILabel* projectLabel = [[UILabel alloc]init];
        projectLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.projectLabel = projectLabel;
        [self addSubview:projectLabel];
        /**
         *  预计所需时间
         */
        UILabel* needTimeLabel = [[UILabel alloc]init];
        needTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.needTimeLabel = needTimeLabel;
        [self addSubview:needTimeLabel];
        
        /**
         *  项目价格
         */
        UILabel* priceLabel = [[UILabel alloc]init];
        priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.priceLabel = priceLabel;
        [self addSubview:priceLabel];
        
        /**
         *  留言
         */
        UILabel* leaveMessageLabel = [[UILabel alloc]init];
        leaveMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        leaveMessageLabel.text = @"留言：";
        self.leaveMessageLabel = leaveMessageLabel;
        [self addSubview:leaveMessageLabel];
        /**
         留言框
         */
        UITextView* textView = [[UITextView alloc]init];
        textView.backgroundColor = [UIColor whiteColor];
        textView.layer.borderWidth = 1;
        textView.layer.borderColor = UIColorFromRGB(0x929292).CGColor;
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:textView];
        self.textView = textView;
        textView.delegate = self;
        
        /**
         限制最多100个字
         */
        UILabel* wordsCountLabel = [[UILabel alloc]init];
        wordsCountLabel.textColor = UIColorFromRGB(0xc0c0c0);
        wordsCountLabel.font = [UIFont systemFontOfSize:11];
        wordsCountLabel.text = @"0/100";
        wordsCountLabel.textAlignment = NSTextAlignmentRight;
        wordsCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:wordsCountLabel];
        self.wordsCountLabel = wordsCountLabel;
        /**
         placeholder
         */
        UILabel* placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.text = @"对本次预约的说明(最多100个字)";
        placeholderLabel.font = [UIFont systemFontOfSize:11];
        placeholderLabel.textColor = UIColorFromRGB(0xc0c0c0);
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [textView addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        /**
          确认预约按钮
         */
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setBackgroundImage:ImageNamed(@"confirm_confirm") forState:UIControlStateNormal];
        [submitButton setTitle:@"确认预约" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:submitButton];
        
        /**
         取消预约按钮
         */
        UIButton* cancelButton = [[UIButton alloc]init];
        [cancelButton setBackgroundImage:ImageNamed(@"confirm_cancel") forState:UIControlStateNormal];
        [cancelButton setTitle:@"取消预约" forState:UIControlStateNormal];
        [cancelButton setTitleColor:UIColorFromRGB(0xc0c0c0) forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:cancelButton];
        
        
        timeLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(self,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        projectLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(timeLabel,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        needTimeLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(projectLabel,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        priceLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(needTimeLabel,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        leaveMessageLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(priceLabel,ScreenHeight*0.03).widthIs(ScreenWidth*0.14).autoHeightRatio(0);
        textView.sd_layout.leftSpaceToView(leaveMessageLabel,0).topEqualToView(leaveMessageLabel).rightSpaceToView(self,ScreenWidth*0.1).heightIs(ScreenHeight*0.2);
        placeholderLabel.sd_layout.leftSpaceToView(textView,ScreenWidth*0.013).topSpaceToView(textView,ScreenWidth*0.013).rightEqualToView(textView).autoHeightRatio(0);
        
        wordsCountLabel.sd_layout.rightEqualToView(textView).topSpaceToView(textView,ScreenHeight*0.015).leftEqualToView(textView).autoHeightRatio(0);
        submitButton.sd_layout.rightSpaceToView(self,ScreenWidth*0.1+1).topSpaceToView(wordsCountLabel,ScreenHeight*0.015).widthIs(ScreenWidth*0.3).heightIs(ScreenHeight*0.052);
         cancelButton.sd_layout.leftSpaceToView(leaveMessageLabel,1).topSpaceToView(wordsCountLabel,ScreenHeight*0.015).widthIs(ScreenWidth*0.3).heightIs(ScreenHeight*0.052);
    }
    return self;
}

-(void)layoutWithTotalTime:(NSString *)totalTime
             withOrderTime:(NSString *)orderTime
          withOrderProject:(NSString *)orderProject
                 withPrice:(NSString*)price
{
    ({
        NSString *contentStr = [NSString stringWithFormat:@"预约时间：%@",orderTime];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc0c0c0) range:NSMakeRange(5, contentStr.length-5)];
        self.timeLabel.attributedText = str;
    });
    ({
        NSString *contentStr = [NSString stringWithFormat:@"预约项目：%@",orderProject];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc0c0c0) range:NSMakeRange(5, contentStr.length-5)];
        self.projectLabel.attributedText = str;
    });
    ({
        
        NSString *contentStr = [NSString stringWithFormat:@"价格：￥%.2f元",price.floatValue];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc0c0c0) range:NSMakeRange(3, contentStr.length-3)];
        self.priceLabel.attributedText = str;
    });
    ({
        NSString *contentStr = [NSString stringWithFormat:@"预计所需时间：%@",totalTime];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xc0c0c0) range:NSMakeRange(7, contentStr.length-7)];
        self.needTimeLabel.attributedText = str;
    });
    
}

/**
 *  点击确认预约按钮
 */
-(void)clickSubmitButton
{
    /**
     *  保证短时间内点击按钮，只有最后一次有效
     */
    [self.timer invalidate];
    self.timer = nil;
    self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self.textView resignFirstResponder];
}

-(void)updateTimer
{
    if ([self.delegate respondsToSelector:@selector(didClickSubmitButtonWithOrderConfirmView:withMessageContent:)])
    {
        [self.delegate didClickSubmitButtonWithOrderConfirmView:self withMessageContent:self.textView.text];
    }
}

/**
 *  点击取消预约按钮
 */
-(void)clickCancelButton
{
    if ([self.delegate respondsToSelector:@selector(didClickCancelButtonWithOrderConfirmView:)])
    {
        [self.delegate didClickCancelButtonWithOrderConfirmView:self];
    }
    
    [self.textView resignFirstResponder];
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholderLabel.hidden = YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (!self.textView.text || [self.textView.text isEqualToString:@""])
    {
        self.placeholderLabel.hidden = NO;
    }
    else
    {
        self.placeholderLabel.hidden = YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
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
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        
        [textView setText:s];
        
        self.wordsCountLabel.text = [NSString stringWithFormat:@"%d/%d",100,MAX_LIMIT_NUMS];
    }
    else
    {
        //不让显示负数
        self.wordsCountLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,existTextNum),MAX_LIMIT_NUMS];
    }
    
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
        
        if (offsetRange.location < MAX_LIMIT_NUMS) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
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
            self.wordsCountLabel.text = [NSString stringWithFormat:@"%d/%ld",100,(long)MAX_LIMIT_NUMS];
        }
        return NO;
    }
    
}

@end
