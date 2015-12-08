//
//  YSComposeToolBarView.h
//  ysWeibo
//
//  Created by ys on 15/12/8.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ComposeToolBarButtonTypeCamera,
    ComposeToolBarButtonTypePicture,
    ComposeToolBarButtonTypeMention,
    ComposeToolBarButtonTypeTrend,
    ComposeToolBarButtonTypeEmotion
}ComposeToolBarButtonType;
@class YSComposeToolBarView;
@protocol YSComposeToolBarViewDelegate <NSObject>
@optional
-(void)composeToolBarView:(YSComposeToolBarView *)toolBarView DidClickedWithType:(ComposeToolBarButtonType)type;

@end


@interface YSComposeToolBarView : UIView
@property (nonatomic,weak)id<YSComposeToolBarViewDelegate> delegate;
@end
