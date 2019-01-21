//
//  TCLAppDelegate.h
//  TCLConfigNet
//
//  Created by 81516741@qq.com on 01/16/2019.
//  Copyright (c) 2019 81516741@qq.com. All rights reserved.
//

@import UIKit;

@interface TCLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,assign)NSTimeInterval interval;
@property (nonatomic , strong) dispatch_source_t timer;
@end
