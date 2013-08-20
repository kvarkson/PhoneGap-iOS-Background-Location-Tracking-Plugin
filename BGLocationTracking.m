//
//  BGLocationTracking.m
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  Copyright (c) 2013 ASHM. All rights reserved.
//

#import "BGLocationTracking.h"

@interface BGLocationTracking ()

- (void)reInitAndStartLocationManager;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end


@implementation BGLocationTracking
@synthesize locationManager, delegate;

- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command {
    [self reInitAndStartLocationManager];
}

- (void)stopUpdatingLocation:(CDVInvokedUrlCommand *)command {
    NSLog(@"stopUpdatingLocation");
    
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
        self.locationManager = nil;
    }
}

- (void)reInitAndStartLocationManager {
    NSLog(@"reInitAndStartLocationManager");
    
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"new location: %@", newLocation);
    
    [self.delegate locationDidUpdate:newLocation];
    
    // notify about location update via local notification
    // UILocalNotification *notif = [[UILocalNotification alloc] init];
    // notif.alertBody = [NSString stringWithFormat:@"found new location: %@", newLocation];
    // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // [[UIApplication sharedApplication] presentLocalNotificationNow:notif];
    
    // stop location manager
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    // TODO: need to re-init location manager with some delay
    [self reInitAndStartLocationManager];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError: %@", error);
    
    [self.delegate locationDidFailWithError:error];

    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    [self reInitAndStartLocationManager];
}

@end