//
//  YYLoadModel.h
//  异步下载
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 d. All rights reserved.
//
#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>

@interface YYLoadModel : NSObject
@property (nonatomic,strong)NSString *download;
@property(nonatomic,strong)NSString * icon;
@property(nonatomic,strong)NSString * name;
@property (nonatomic,strong)UIImage *image;



+(instancetype)loadWithDict:(NSDictionary *)dict;


//download = "1951\U4e07";
//icon = "http://p16.qhimg.com/dr/48_48_/t018f89d6e0922f75a1.png";
//name = "\U6740\U624b2";

@end
