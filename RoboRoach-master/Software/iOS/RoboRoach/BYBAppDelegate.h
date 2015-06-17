//
//  BYBAppDelegate.h
//  RoboRoach
//
//  Created by Greg Gage on 4/13/13.
//  Copyright (c) 2013 Backyard Brains. All rights reserved.
//
//

#import <UIKit/UIKit.h>

#ifdef TESTFLIGHT
#import "TestFlight.h"
#endif

#define BYB_COMMAND_NOTIFICATION @"bybCommandNotification"

#define BYB_SHARED_USER_DEFAULTS @"group.bybremote"
#define BYB_SHARED_INFO_ACTIVE @"bybActivityInfo"
#define BYB_SHARED_INFO_CONNECTION @"bybConnectionInfo"
#define BYB_SHARED_INFO_DURATION @"bybDurationInfo"
#define BYB_SHARED_INFO_PULSE_WIDTH @"bybPulseWidthInfo"
#define BYB_SHARED_INFO_GAIN @"bybGainInfo"
#define BYB_SHARED_INFO_FREQUENCY @"bybFrequencyInfo"
#define BYB_SHARED_INFO_RANDOM @"bybRandomInfo"

@interface BYBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


