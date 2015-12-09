//
//  YSFormData.h
//  ysWeibo
//
//  Created by ys on 15/12/9.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSFormData : NSObject

@property (nonatomic,strong)NSData *data;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *mimeType;

@property (nonatomic,copy)NSString *fileName;

@end
