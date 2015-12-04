//
//  YSaccount.h
//  ysWeibo
//
//  Created by ys on 15/12/3.
//  Copyright (c) 2015年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSaccount : NSObject<NSCoding>
@property (nonatomic,copy)NSString *access_token;
@property (nonatomic,strong)NSDate *expiresTime;
@property (nonatomic,assign)long long expires_in;
@property (nonatomic,assign)long long remind_in;
@property (nonatomic,assign)long long uid;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
