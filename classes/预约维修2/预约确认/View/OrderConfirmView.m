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
@end
@implementation OrderConfirmView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        /**
         *  预约时间
         */
        UILabel* timeLabel = [[UILabel alloc]init];
        timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:timeLabel];
        /**
         *  预约项目
         */
        UILabel* projectLabel = [[UILabel alloc]init];
        projectLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:projectLabel];
        /**
         *  预计所需时间
         */
        UILabel* needTimeLabel = [[UILabel alloc]init];
        needTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:needTimeLabel];
        
        /**
         *  留言
         */
        UILabel* leaveMessageLabel = [[UILabel alloc]init];
        leaveMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
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
        placeholderLabel.text = @"请在这里写下您的留言......";
        placeholderLabel.font = [UIFont systemFontOfSize:11];
        placeholderLabel.textColor = UIColorFromRGB(0xc0c0c0);
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        /**
          确认预约按钮
         */
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [submitButton setTitle:@"确认预约" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(clickSubmitButton) forControlEvents:UIControlEventTouchUpInside];
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:submitButton];
        
        
        timeLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(self,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        projectLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(timeLabel,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        needTimeLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(projectLabel,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.027).autoHeightRatio(0);
        leaveMessageLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.027).topSpaceToView(needTimeLabel,ScreenHeight*0.03).widthIs(ScreenWidth*0.14).autoHeightRatio(0);
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    NSString*  timeout = [TransferTimeSingleton.shareTransfer transferCountDownWithTimeString:@""]; //倒计时时间
}
@end
