//
//  ViewController.h
//  BGLocationTrackingPlugin
//
//  Created by Alex Shmaliy on 8/16/13.
//  Copyright (c) 2013 ASHM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLocationUpdater.h"

@interface ViewController : UIViewController <MyLocationUpdaterDelegate>

- (IBAction)onStartUpdateClicked:(id)sender;
- (IBAction)onStopClicked:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UITextView *statusTextView;

@end
