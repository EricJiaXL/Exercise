//
//  appModel.h
//  解析jason数据
//
//  Created by 贾晓磊 on 17/4/3.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appModel : NSObject

@property (nonatomic,copy)NSString *download;

@property (nonatomic,copy)NSString *icon;

@property (nonatomic,copy)NSString *name;


+ (instancetype)appModelWithDictionary: (NSDictionary *)dictionary;
@end
