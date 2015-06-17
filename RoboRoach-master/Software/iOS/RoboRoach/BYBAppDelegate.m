//
//  BYBAppDelegate.m
//  RoboRoach
//
//  Created by Greg Gage on 4/13/13.
//  Copyright (c) 2013 Backyard Brains. All rights reserved.
//

#import "BYBAppDelegate.h"
#import "BYBRoboRoach.h"
@implementation BYBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations" //I hate compiler warnings.
    

  //  [TestFlight takeOff:@"77969e65-27dc-49e0-81fe-03f627c33631"];

#pragma clang diagnostic pop
    
    
    //init shared variables for watch
    NSUserDefaults * bybRemoteSharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:BYB_SHARED_USER_DEFAULTS];
    [bybRemoteSharedDefaults setObject:@"false" forKey:BYB_SHARED_INFO_CONNECTION];
    [bybRemoteSharedDefaults setObject:[NSNumber numberWithFloat:0] forKey:BYB_SHARED_INFO_DURATION];
    [bybRemoteSharedDefaults setObject:[NSNumber numberWithFloat:0] forKey:BYB_SHARED_INFO_PULSE_WIDTH];
    [bybRemoteSharedDefaults setObject:[NSNumber numberWithFloat:0] forKey:BYB_SHARED_INFO_GAIN];
    [bybRemoteSharedDefaults setObject:[NSNumber numberWithFloat:0] forKey:BYB_SHARED_INFO_FREQUENCY];
    [bybRemoteSharedDefaults setObject:@"active" forKey:BYB_SHARED_INFO_ACTIVE];
    [bybRemoteSharedDefaults setObject:@"false" forKey:BYB_SHARED_INFO_RANDOM];
    [bybRemoteSharedDefaults synchronize];
    
    return YES;
}


- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply {
    
    NSString *messageValue = [userInfo objectForKey:@"command"];
    
    if([messageValue isEqualToString:@"left"])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BYB_COMMAND_NOTIFICATION object:@"left"];
        reply(@{@"command received":messageValue});
    }
    
    if([messageValue isEqualToString:@"right"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:BYB_COMMAND_NOTIFICATION object:@"right"];
        reply(@{@"command received":messageValue});
    }
    
    if([messageValue isEqualToString:@"connect"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:BYB_COMMAND_NOTIFICATION object:@"connect"];
        reply(@{@"command received":messageValue});
    }
    
    if([messageValue isEqualToString:@"disconnect"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:BYB_COMMAND_NOTIFICATION object:@"disconnect"];
        reply(@{@"command received":messageValue});
    }
    
    
    
    
    
}

//
// Set flag in shared variables so that watch knows if application is active
//
-(void) applicationIsActive:(BOOL) active
{
    NSUserDefaults * bybRemoteSharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:BYB_SHARED_USER_DEFAULTS];
    if(active)
    {
        [bybRemoteSharedDefaults setObject:@"active" forKey:BYB_SHARED_INFO_ACTIVE];
    }
    else
    {
        [bybRemoteSharedDefaults setObject:@"nonactive" forKey:BYB_SHARED_INFO_ACTIVE];
    }
    [bybRemoteSharedDefaults synchronize];
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        [self applicationIsActive:NO];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self applicationIsActive:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
       [self applicationIsActive:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       [self applicationIsActive:NO];
}


@end
