//
//  LocalSearchDeviceTool.h
//  TclIntelliCom
//
//  Created by lingda on 2019/1/10.
//  Copyright © 2019年 tcl. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SearchLocalDeviceTool : NSObject
/**
 * 搜索手机所处wifi下的所有入网设备
 */
+ (void)startSearcheDevice:(void(^)(id deviceInfo))result;
/**
 * 配置udp广播的 host port 默认  host:@"255.255.255.255" port:@"10075"
 */
+ (void)configUdpSocket:(NSString *)host port:(NSString *)port;
/**
 * udp包的内容  默认 @"<searchDevice></searchDevice>"
 */
+ (void)configUdpPacket:(NSString *)packet;
+ (NSString *)udpPacket;
/**
 * 是否开启打印 默认NO
 */
+ (void)configEnabelLog:(BOOL)enableLog;
+ (BOOL)enableLog;
/**
 * 发搜索包的间隔时间 默认 1 秒
 */
+ (void)configIntervalSendPacket:(NSInteger)intervalSendPacket;
+ (NSInteger)intervalSendPacket;
/**
 * 停止发送udp包
 */
+ (void)configIsStopSendPacket:(BOOL)isStopSendPacket;
+ (BOOL)isStopSendPacket;
@end


