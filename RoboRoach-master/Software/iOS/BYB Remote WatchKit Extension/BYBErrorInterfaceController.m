//
//  BYBErrorInterfaceController.m
//  RoboRoach
//
//  Created by Stanislav Mircic on 6/16/15.
//  Copyright (c) 2015 Backyard Brains. All rights reserved.
//

#import "BYBErrorInterfaceController.h"

@interface BYBErrorInterfaceController ()

@end

@implementation BYBErrorInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)okButtonClick {
    [self dismissController];
}
@end



