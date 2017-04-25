//
//  DownloadManager.h
//  仿SDWebImage
//
//  Created by 贾晓磊 on 17/4/25.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DownloadOperation.h"

@interface DownloadManager : NSObject

+ (instancetype)sharedManager;


/**
 单例管理下载的主方法

 @param urlString 单例接收控制器传入的图片地址
 @param finishedBlock 单例接收控制器传入的图片下载完成的回掉,把图片回掉VC
 */
- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void(^)(UIImage *image))finishedBlock;


/**
 单例管理取消操作

 @param lastURLString 上一次正在执行的操作对应的地址
 */
- (void)cancelWithLastURLString:(NSString *)lastURLString;
@end
