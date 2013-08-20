//
//  MyLocationUpdater.m
//  BGLocationTrackingPlugin
//
//  Created by Alex Shmaliy on 8/20/13.
//  Copyright (c) 2013 ASHM. All rights reserved.
//

#import "MyLocationUpdater.h"

@interface MyLocationUpdater ()

- (void)reInitAndStartLocationManager;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end


@implementation MyLocationUpdater
@synthesize locationManager, delegate;

- (void)startUpdatingLocation {
    [self reInitAndStartLocationManager];
}

- (void)stopUpdatingLocation {
    NSLog(@"stopUpdatingLocation");
    
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
        self.locationManager = nil;
    }
}

- (void)reInitAndStartLocationManager {
    NSLog(@"reInitAndStartLocationManager");
    
    [self stopUpdatingLocation];
    
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //NSLog(@"new location: %@", newLocation);
    
    [self.delegate locationDidUpdate:newLocation];
    
    // notify about location update via local notification
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.alertBody = [NSString stringWithFormat:@"found new location: %@", newLocation];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] presentLocalNotificationNow:notif];
    
    // stop location manager
    [self stopUpdatingLocation];
    
    // TODO: need to re-init location manager with some delay
    [self reInitAndStartLocationManager];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError: %@", error);
    
    [self.delegate locationDidFailWithError:error];

    [self stopUpdatingLocation];
    
    [self reInitAndStartLocationManager];
}

@end
