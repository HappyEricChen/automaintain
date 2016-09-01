
//
//  MyMessageView.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyMessageView.h"

@interface MyMessageView()<UITextViewDelegate>
/**
 *  评论内容
 */

/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation MyMessageView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        
        UIView* baseView = [[UIView alloc]init];
        [self addSubview:baseView];
        
        UITextView* textView = [[UITextView alloc]init];
        textView.backgroundColor = [UIColor whiteColor];
        textView.layer.borderWidth = 1;
        textView.layer.borderColor = UIColorFromRGB(0x929292).CGColor;
        [baseView addSubview:textView];
        self.textView = textView;
        textView.delegate = self;
        
        
        UILabel* wordsCountLabel = [[UILabel alloc]init];
        wordsCountLabel.textColor = UIColorFromRGB(0xc0c0c0);
        wordsCountLabel.font = [UIFont systemFontOfSize:11];
        wordsCountLabel.text = @"0/100";
        wordsCountLabel.textAlignment = NSTextAlignmentRight;
        [baseView addSubview:wordsCountLabel];
        self.wordsCountLabel = wordsCountLabel;
        
        UILabel* placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.text = @"请在这里写下您的留言......";
        placeholderLabel.font = [UIFont systemFontOfSize:11];
        placeholderLabel.textColor = UIColorFromRGB(0xc0c0c0);
        [textView addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [baseView addSubview:submitButton];
        
        baseView.sd_layout.leftSpaceToView(self,ScreenWidth*0.035).rightSpaceToView(self,ScreenWidth*0.035).topSpaceToView(self,ScreenHeight*0.022).heightIs(ScreenHeight*0.425);
        
        textView.sd_layout.leftEqualToView(baseView).rightEqualToView(baseView).topEqualToView(baseView).heightIs(ScreenHeight*0.2);
        submitButton.sd_layout.leftSpaceToView(baseView,3).rightSpaceToView(baseView,3).topSpaceToView(textView,ScreenHeight*0.05).heightIs(ScreenHeight*0.05);
        wordsCountLabel.sd_layout.rightEqualToView(textView).topSpaceToView(textView,ScreenWidth*0.035).leftSpaceToView(baseView,ScreenWidth*0.026).autoHeightRatio(0);
        placeholderLabel.sd_layout.leftSpaceToView(textView,ScreenWidth*0.01).topSpaceToView(textView,ScreenHeight*0.01).rightEqualToView(textView).autoHeightRatio(0);
        
    }
    return self;
}

#pragma mark -UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    
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

#pragma mark - 点击提交按钮
-(void)clickSubmitButton
{
    /**
     *  保证短时间内点击按钮，只有最后一次有效
     */
    [self.timer invalidate];
    self.timer = nil;
    self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)updateTimer
{
    if ([self.delegate respondsToSelector:@selector(didSelectedSubmitButtonWithMyMessageView:withMessageContent:)])
    {
        [self.delegate didSelectedSubmitButtonWithMyMessageView:self withMessageContent:self.textView.text];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.textView.text isEqualToString:@""])
    {
        self.placeholderLabel.hidden = NO;
    }
    
    [self endEditing:YES];//回缩键盘
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholderLabel.hidden = YES;
}
@end
