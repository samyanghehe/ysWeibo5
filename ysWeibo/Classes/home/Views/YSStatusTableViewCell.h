//
//  YSStatusTableViewCell.h
//  ysWeibo
//
//  Created by ys on 15/12/4.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSStatusFrame;

@interface YSStatusTableViewCell : UITableViewCell

@property (nonatomic,strong)YSStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
