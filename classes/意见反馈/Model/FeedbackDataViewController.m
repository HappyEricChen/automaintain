//
//  FeedbackDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FeedbackDataViewController.h"
#import "FeedbackFirstCollectionViewCell.h"
#import "FeedbackSecondCollectionViewCell.h"
#import "FeedbackThirdCollectionViewCell.h"

@implementation FeedbackDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"意见反馈"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [_collectionView setExclusiveTouch:YES];

        [_collectionView registerClass:[FeedbackFirstCollectionViewCell class] forCellWithReuseIdentifier:FeedbackFirstCollectionViewCellId];
        [_collectionView registerClass:[FeedbackSecondCollectionViewCell class] forCellWithReuseIdentifier:FeedbackSecondCollectionViewCellId];
        [_collectionView registerClass:[FeedbackThirdCollectionViewCell class] forCellWithReuseIdentifier:FeedbackThirdCollectionViewCellId];
    }
    return _collectionView;
}


-(UITableView *)listTableView
{
    if (!_listTableView)
    {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
    }
    return _listTableView;
}
-(void)postFeedbackWithAccessCode:(NSString *)accessCode
                         withType:(NSString *)type
               withCommentContent:(NSString *)commentContent
                     withCallback:(Callback)callback
{
    [AutomaintainAPI postFeedbackWithAccessCode:accessCode
                                       withType:type
                             withCommentContent:commentContent
                                   withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}
@end
