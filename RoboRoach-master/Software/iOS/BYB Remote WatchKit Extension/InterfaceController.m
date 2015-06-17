//
//  InterfaceController.m
//  BYB Remote WatchKit Extension
//
//  Created by Stanislav Mircic on 6/14/15.
//  Copyright (c) 2015 Backyard Brains. All rights reserved.
//

#import "InterfaceController.h"
#define TIME_TO_WAIT_FOR_CONNECTION 10

@interface InterfaceController()
{
    int whaitingForConnection;
    int appIsConnected;
    int animationDots;
    BOOL mainAppIsActive;
}

@end


@implementation InterfaceController

@synthesize actionsGroup;
@synthesize commandBtn;
@synthesize settingsBtn;
@synthesize connectBtn;
@synthesize statusLabel;
@synthesize connectingLabel;
@synthesize connectingAnimation;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    appIsConnected = 0;
    // Configure interface objects here.
    animationDots = 0;
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    if(appIsConnected)
    {
        [actionsGroup setHidden:false];
    }
    else
    {
        [actionsGroup setHidden:true];
    }
    
    animationDots = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.6
                                     target:self
                                   selector:@selector(periodicCode:)
                                   userInfo:nil
                                    repeats:YES];
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    appIsConnected = 0;

}

-(void)periodicCode:(NSTimer *)timer {
    [self checkStateOfConnection];
    
    
    if(appIsConnected == 2)
    {
        [connectBtn setTitle:@"Disconnect"];
        [connectBtn setHidden:false];
        
       // [connectingLabel setHidden:true];
        [connectingAnimation setHidden:true];
        
        [statusLabel setText:@"Remote connected"];
        
        [actionsGroup setHidden:false];
        animationDots = 0;
    }
    else if(appIsConnected == 1)
    {
        [connectBtn setTitle:@"Disconnect"];
        [connectBtn setHidden:true];
        
//        [connectingLabel setHidden:false];
        [connectingAnimation setHidden:false];
        
        animationDots++;
        if(animationDots>5)
        {
            animationDots = 0;
        }
       
        
        [statusLabel setText:@"Searching for remote"];
        
        NSMutableString * dotsString = [[NSMutableString alloc] initWithString:@"."];
        for(int i=0;i<animationDots;i++)
        {
            [dotsString appendString:@"."];
        }
        
        [connectingLabel setText:dotsString];
        
        [actionsGroup setHidden:true];
    }
    else
    {
        animationDots = 0;
        [connectBtn setTitle:@"Connect"];
        [connectBtn setHidden:false];
        
//        [connectingLabel setHidden:true];
        [connectingAnimation setHidden:true];
        
        [statusLabel setText:@"Remote not connected"];
        
        [actionsGroup setHidden:true];
    
    }
  

}

-(void) checkStateOfConnection
{
    NSUserDefaults * bybRemoteSharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:BYB_SHARED_USER_DEFAULTS];
    [bybRemoteSharedDefaults synchronize];
    NSString * connectionState = [bybRemoteSharedDefaults stringForKey:BYB_SHARED_INFO_CONNECTION];
    NSLog(@"State of connection: %@\n", connectionState);
    if([connectionState isEqualToString:@"true"])
    {
        appIsConnected = 2;
    }
    else if([connectionState isEqualToString:@"search"])
    {
        appIsConnected = 1;
    }
    else
    {
        appIsConnected = 0;
    }
    
    NSString * mainAppState = [bybRemoteSharedDefaults stringForKey:BYB_SHARED_INFO_ACTIVE];
    mainAppIsActive = [mainAppState isEqualToString:@"active"];
}

- (IBAction)leftBtnClick {
    
    //Send count to parent application
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[@"left"] forKeys:@[@"command"]];
    
    //Handle reciever in app delegate of parent app
    [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@ %@",replyInfo, error);
    }];
    
    
}

- (IBAction)rightBtnClick {
    //Send count to parent application
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[@"right"] forKeys:@[@"command"]];
    
    //Handle reciever in app delegate of parent app
    [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@ %@",replyInfo, error);
    }];
}


- (IBAction)connectBtnClick {
    
    NSUserDefaults * bybRemoteSharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:BYB_SHARED_USER_DEFAULTS];
    [bybRemoteSharedDefaults synchronize];
    NSString * connectionState = [bybRemoteSharedDefaults stringForKey:BYB_SHARED_INFO_CONNECTION];

    if([connectionState isEqualToString:@"true"])
    {
         NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[@"disconnect"] forKeys:@[@"command"]];
        [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
            NSLog(@"%@ %@",replyInfo, error);
        }];
        
    }
    else if([connectionState isEqualToString:@"false"])
    {
        //check if main app on iPhone is active
        if(!mainAppIsActive)
        {
            [self presentControllerWithName:@"errorview" context:nil];
            return;
        }
        
        //send commands to scan for remote and connect
        NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[@"connect"] forKeys:@[@"command"]];
        [WKInterfaceController openParentApplication:applicationData reply:^(NSDictionary *replyInfo, NSError *error) {
            NSLog(@"%@ %@",replyInfo, error);
        }];
    }
    
}

@end



