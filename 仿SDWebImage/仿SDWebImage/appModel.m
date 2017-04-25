//
//  appModel.m
//  解析jason数据
//
//  Created by 贾晓磊 on 17/4/3.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import "appModel.h"


@implementation appModel

+ (instancetype)appModelWithDictionary: (NSDictionary *)dictionary {
    appModel *model = [[appModel alloc] init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
