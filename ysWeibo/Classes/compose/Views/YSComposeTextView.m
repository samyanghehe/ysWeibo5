//
//  YSComposeTextView.m
//  ysWeibo
//
//  Created by ys on 15/12/8.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import "YSComposeTextView.h"

@interface YSComposeTextView()
@property (nonatomic,weak)UILabel *placeholderLabel;
@end

@implementation YSComposeTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
//        placeholderLabel.font = self.font;
        self.placeholderLabel = placeholderLabel;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(composeTextViewDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)composeTextViewDidChange
{
    if (self.text.length) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = _placeholder;
    if (placeholder.length) {
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 * placeholderY;
        CGSize placeholderSize = [placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}
@end
