//
//  TCLViewController0.m
//  TCLConfigNet_Example
//
//  Created by lingda on 2019/1/21.
//  Copyright © 2019年 81516741@qq.com. All rights reserved.
//

#import "TCLViewController0.h"

@interface TCLViewController0 ()
@property (nonatomic , strong) NSTimer * timer;
@end

@implementation TCLViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.timer invalidate];
    });
}
                  
- (void)tick {
    NSLog(@"tick");
}

- (void)dealloc {
    NSLog(@"销毁");
}
@end
