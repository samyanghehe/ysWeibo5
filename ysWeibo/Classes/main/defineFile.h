//
//  defineFile.h
//  ysWeibo
//
//  Created by ys on 15/12/7.
//  Copyright (c) 2015年 ys. All rights reserved.
//
#define YSAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#define YSStatusCellBorder 5
/** 昵称的字体 */
#define YSStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define YSRetweetNameFont YSStatusNameFont
/** 时间的字体 */
#define YSStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define YSStatusSourceFont YSStatusTimeFont
/** 正文的字体 */
#define YSStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define YSRetweetContentFont YSStatusContentFont
/** 表格缝宽 */
#define YSStatusTableBorder 7

#define YStitleButtonImageW 20

#define IWPhotoW 90
#define IWPhotoH 90
#define IWPhotoMargin 10

#define ios7 ( [[UIDevice currentDevice].systemVersion doubleValue]>7.0)