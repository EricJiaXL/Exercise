//
//  DownloadOperation.h
//  仿SDWebImage
//
//  Created by 贾晓磊 on 17/4/21.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadOperation : NSOperation




/**
 类方法,实例化自定义操作, 在实例化自定义操作同时,传入图片地址和下载完成的回掉

 @param URLString 接收VC传入的图片地址
 @param finishedBlock 接收VC传入的下载完成的回掉
 @return 自定义下载操作对象
 */
+ (instancetype)downloadWithURLString:(NSString *)URLString finishedBlock:(void(^)(UIImage *image))finishedBlock;
@end
