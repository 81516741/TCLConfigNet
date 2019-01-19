//
//  DeviceToNetTool.h
//  TclIntelliCom
//
//  Created by lingda on 2019/1/10.
//  Copyright © 2019年 tcl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceModel.h"

typedef NS_ENUM(NSInteger){
    DeviceToNetPerStepStateNone,
    DeviceToNetPerStepStateSuccess,
    DeviceToNetPerStepStateFailure,
    DeviceToNetPerStepStateTimeOut
} DeviceToNetPerStepState;

@interface DeviceToNetTool : NSObject
+ (BOOL)isConfiging;//是否正在配网
/**
 * 保存设备需要入网路由器的信息
 */
+ (void)saveWifiNameAndPassword:(NSString *)wifiName password:(NSString *)password;
+ (NSString *)deviceToNetWifiName;//路由器SSID
+ (NSString *)deviceToNetWifiPassword;//路由器密码
/**
 * 配置本地udp搜索设备的信息
 * 默认 host = @"255.255.255" port = @"10075"
 */
+ (void)configUdpHost:(NSString *)host port:(NSString *)port;
/**
 * 配置设备热点名的规则  传入正则表达式
 * 默认规则 @"tcl_[a-zA-Z0-9]+_t\\*ap_[a-zA-Z0-9]+(.*)"
 */
+ (void)configDeviceHotpotRules:(NSArray<NSString *> *)rules;
+ (NSArray<NSString *> *)deviceHotpotRules;//设备热点的正则
/**
 * 判断是否是设备热点（是根据正则判断的）
 */
+ (BOOL)isDeviceHotpot:(NSString *)maybeDeviceHotpot;
+ (NSString *)deviceWifiHotName;//设备热点
/**
 * 会否打印 默认YES
 */
+ (void)enableLog:(BOOL)enable;
#pragma mark - Wifi设备配网
/**
 * 配网Step:1，检测设备热点连接是否稳定
 * 连上设备热点后，有些设备连上后会马上自动断开，所以要先检测热点是否连接稳定
 */
+ (void)checkDeviceWifiHotConnect:(void(^)(DeviceToNetPerStepState state))result;
/**
 * 配网Step:2，与设备建立tcp连接
 */
+ (void)connectToDeviceByHost:(NSString *)host port:(NSString *)port result:(void(^)(DeviceToNetPerStepState state))result;
/**
 * 配网Step:3，发送wifiName和password
 */
+ (void)sendWifiNameAndPassword:(NSString *)sendMsg result:(BOOL(^)(NSString * msgInfo))result;
/**
 * 配网Step:4，重连原来wifi的检测  isConnectedBlock返回的是当前tcp是否连接上了服务器
 */
+ (void)checkIsReConnectedPreWifi:(void(^)(BOOL isOK))result serviceTcpConnected:(BOOL(^)(DeviceToNetPerStepState state))isConnectedBlock;
/**
 * 配网Step:5，检测设备的udp包,看设备是否已经上报到服务器了
 * randcode  随机码
 * deviceInfo 如果deviceInfo为nil，则配网失败
 */
+ (void)checkDeviceIsReportToService:(NSString *)randcode result:(BOOL(^)(DeviceModel * device))block;
/**
 * 配网Step:6，获取设备经纬度信息，如果没有开启定位权限，则经纬度信息为空字符串
 */
+ (void)getDeviceLocationInfo:(void(^)(DeviceModel * device))block;
/**
 * 主动连接某个wifi 支持iOS11以上版本
 */
+ (void)connectWifi:(NSString *)wifiName password:(NSString *)password;
/**
 * 停止wifi设备配网流程
 */
+ (void)stopDeviceToNetProcess;


#pragma mark - 开始网关子设备配网
/**
 * 开始网关设备的配网
 * gateWayID 网关的设备ID
 */
+ (void)startSubDeviceToNet:(NSString *)gateWayID result:(void (^)(DeviceModel * model))block;
/**
 * 停止网关子设备设备配网流程
 */
+ (void)stopSubDeviceToNetProcess;
@end
