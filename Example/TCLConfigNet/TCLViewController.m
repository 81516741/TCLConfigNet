//
//  TCLViewController.m
//  TCLDeviceConfigToNetLib
//
//  Created by lingda on 01/12/2019.
//  Copyright (c) 2019 lingda. All rights reserved.
//<searchDevice deviceid="45D104" randcode="lYZm]\glYi"></searchDevice>

#import "TCLViewController.h"
#import "TCLConfigNet.h"

@interface TCLViewController ()
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UITextField *countLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;
@end

@implementation TCLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)stopSearch:(id)sender {
    [SearchLocalDeviceTool stopSearchDevice];
}

- (IBAction)stopConfiNet:(id)sender {
    [DeviceToNetTool stopDeviceToNetProcess];
}
- (IBAction)subDevice:(id)sender {
    self.desLabel.text = @"开始网关子设备的配网";
    [DeviceToNetTool startSubDeviceToNet:@"2003179" result:^(DeviceModel * device) {
        self.desLabel.text = [NSString stringWithFormat:@"%@--%@",device.step,device.tid];
        if (device == nil) {
            self.desLabel.text = @"网关子设备配网超时";
        }
    }];
}

- (IBAction)searchWifiDevice:(id)sender {
    self.desLabel.text = @"搜索wifi设备";
    [SearchLocalDeviceTool startSearcheDevice:nil result:^(NSArray * deviceInfo) {
        self.desLabel.text = [NSString stringWithFormat: @"搜索到 %d 个设备",(int)deviceInfo.count];
        for (DeviceModel * model in deviceInfo) {
            if ([[model.devMac stringByReplacingOccurrencesOfString:@":" withString:@""].uppercaseString containsString:@"45D104"]) {
                NSLog(@"￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥");
            }
        }
    }];
}
- (IBAction)connectWifi:(id)sender {
    [DeviceToNetTool connectWifi:@"H3C" password:@"test1234"];
}


- (IBAction)searchNew:(id)sender {
    [DeviceToNetTool stopSubDeviceToNetProcess];
}
- (IBAction)click:(id)sender {
    [DeviceToNetTool saveWifiNameAndPassword:@"TP-3F-APP" password:@"tcl12345"];
//    [DeviceToNetTool saveWifiNameAndPassword:self.countLabel.text password:self.passwordLabel.text];
    [DeviceToNetTool enableLog:YES];
    [self configDeviceToNetStep1];
}

- (void)configDeviceToNetStep1 {
    NSLog(@"-------稳定检测");
    self.desLabel.text = @"稳定检测...";
    [DeviceToNetTool checkDeviceWifiHotConnect:^(DeviceToNetPerStepState state) {
        if (state == DeviceToNetPerStepStateSuccess) {
            NSLog(@"-----稳定检测成功");
            self.desLabel.text = @"稳定检测成功";
            [self configDeviceToNetStep2];
        } else {
            NSLog(@"-----稳定检测失败");
            self.desLabel.text = @"稳定检测失败";
        }
    }];
}
- (void)configDeviceToNetStep2 {
    NSLog(@"-------连接设备热点");
    self.desLabel.text = @"连接设备热点...";
    [DeviceToNetTool connectToDeviceByHost:@"192.168.1.1" port:@"10000" result:^(DeviceToNetPerStepState state) {
        if (state == DeviceToNetPerStepStateSuccess)  {
            NSLog(@"-----连接设备成功");
            self.desLabel.text = @"连接设备成功";
            [self configDeviceToNetStep3];
        } else {
            NSLog(@"-----连接设备失败");
            self.desLabel.text = @"连接设备失败";
        }
    }];
}
- (void)configDeviceToNetStep3 {
    NSLog(@"-------发送路由器信息");
    self.desLabel.text = @"发送路由器信息...";
    [DeviceToNetTool sendWifiNameAndPassword:^(DeviceToNetPerStepState state) {
        if (state == DeviceToNetPerStepStateSuccess) {
            self.desLabel.text = @"发送路由器SSID和密码给设备成功";
            NSLog(@"-----发送路由器SSID和密码给设备成功");
            [self configDeviceToNetStep4];
        } else {
            NSLog(@"-----发送路由器SSID和密码给设备失败");
            self.desLabel.text = @"发送路由器SSID和密码给设备失败";
        }
    }];
}
- (void)configDeviceToNetStep4 {
    NSLog(@"-------检测是否切回原来wifi");
    self.desLabel.text = @"检测是否切回原来wifi...";
    [DeviceToNetTool checkIsReConnectedPreWifi:^(BOOL ok) {
        if (!ok) {
            NSLog(@"----请切回原来的Wifi网络");
            self.desLabel.text = @"请切回原来的Wifi网络";
        }
    } serviceTcpConnected:^BOOL(DeviceToNetPerStepState state) {
        if (state == DeviceToNetPerStepStateSuccess) {
            NSLog(@"----连接服务器成功");
            self.desLabel.text = @"连接服务器成功";
            [self configDeviceToNetStep5];
        } else if (state == DeviceToNetPerStepStateTimeOut) {
            NSLog(@"----连接服务器超时");
            self.desLabel.text = @"连接服务器超时";
        }
        return YES;
    }];
    
}
- (void)configDeviceToNetStep5 {
    NSLog(@"-------udp搜索设备是否入网成功");
    self.desLabel.text = @"udp搜索设备是否入网成功...";
    [DeviceToNetTool checkDeviceIsReportToService:@"lYZm]\\glYi" result:^BOOL(id deviceInfo) {
        if (deviceInfo) {
            [self configDeviceToNetStep6];
            self.desLabel.text = @"设备入网成功";
        } else {
            self.desLabel.text = @"设备入网失败";
        }
        return YES;
    }];
}
- (void)configDeviceToNetStep6 {
    NSLog(@"-------获取经纬度");
    self.desLabel.text = @"获取经纬度...";
    [DeviceToNetTool getDeviceLocationInfo:^(DeviceModel * device) {
        self.desLabel.text = @"获取经纬度成功";
    }];
}

@end
