//
//  DownloadOperation.m
//  仿SDWebImage
//
//  Created by 贾晓磊 on 17/4/21.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import "DownloadOperation.h"
@interface DownloadOperation ()

@property (nonatomic,copy) NSString *URLString;

@property (nonatomic,copy) void(^finishedBlock)(UIImage *image);

@end

@implementation DownloadOperation

/*
 重写自定义操作的入口方法
 任何操作在执行时都会默认的调用这个方法
 默认在子线程执行
 */

- (void)main {
    //一般在耗时操作后边做判断
//    if (self.isCancelled) {
//        return;
//    }
    
    NSLog(@"%@",self.URLString);
    
    NSURL *url = [NSURL URLWithString:self.URLString];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    
    if (self.isCancelled) {
        return;
    }
    
    //把图片对象传递到manager
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.finishedBlock(image);
    }];
    
    
}

+ (instancetype)downloadWithURLString:(NSString *)URLString finishedBlock:(void(^)(UIImage *image))finishedBlock
{
    DownloadOperation *op = [[DownloadOperation alloc] init];
    
    op.URLString = URLString;
    op.finishedBlock = finishedBlock;
    
    return op;
}

@end
