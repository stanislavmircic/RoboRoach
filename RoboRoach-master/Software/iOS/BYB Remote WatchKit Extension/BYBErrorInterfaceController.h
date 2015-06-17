//
//  BYBErrorInterfaceController.h
//  RoboRoach
//
//  Created by Stanislav Mircic on 6/16/15.
//  Copyright (c) 2015 Backyard Brains. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface BYBErrorInterfaceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *mainLbl;
@property (strong, nonatomic) IBOutlet WKInterfaceButton *okButton;

- (IBAction)okButtonClick;
@end
