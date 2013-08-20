//
//  ViewController.m
//  BGLocationTrackingPlugin
//
//  Created by Alex Shmaliy on 8/16/13.
//  Copyright (c) 2013 ASHM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    MyLocationUpdater *locUpdater;
}

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        locUpdater = [[MyLocationUpdater alloc] init];
        locUpdater.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)locationDidUpdate:(CLLocation *)newLocation {
    NSLog(@"locationDidUpdate: %@", newLocation);
    
    // show new location in textView
    self.statusTextView.text = [newLocation description];
}

- (void)locationDidFailWithError:(NSError *)error {
    NSLog(@"locationDidFailWithError: %@", error);
    
    self.statusTextView.text = @"locationDidFailWithError at time %@", [[NSDate date] description];
}

- (void)viewDidUnload {    
    [self setStatusTextView:nil];
    [super viewDidUnload];
}

- (IBAction)onStartUpdateClicked:(id)sender {
    [locUpdater startUpdatingLocation];
}

- (IBAction)onStopClicked:(id)sender {
    [locUpdater stopUpdatingLocation];
}

- (void)dealloc {
    [locUpdater stopUpdatingLocation];
    locUpdater.delegate = nil;
}

@end
