//
//  InterfaceController.h
//  BYB Remote WatchKit Extension
//
//  Created by Stanislav Mircic on 6/14/15.
//  Copyright (c) 2015 Backyard Brains. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#define BYB_SHARED_USER_DEFAULTS @"group.bybremote"
#define BYB_SHARED_INFO_CONNECTION @"bybConnectionInfo"
#define BYB_SHARED_INFO_DURATION @"bybDurationInfo"
#define BYB_SHARED_INFO_PULSE_WIDTH @"bybPulseWidthInfo"
#define BYB_SHARED_INFO_GAIN @"bybGainInfo"
#define BYB_SHARED_INFO_FREQUENCY @"bybFrequencyInfo"
#define BYB_SHARED_INFO_RANDOM @"bybRandomInfo"


@interface InterfaceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceButton *leftBtn;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *rightBtn;
- (IBAction)leftBtnClick;
- (IBAction)rightBtnClick;

@property (strong, nonatomic) IBOutlet WKInterfaceButton *connectBtn;
- (IBAction)connectBtnClick;

@property (strong, nonatomic) IBOutlet WKInterfaceButton *commandBtn;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *settingsBtn;
@property (strong, nonatomic) IBOutlet WKInterfaceGroup *actionsGroup;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *connectingLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *statusLabel;

@end
