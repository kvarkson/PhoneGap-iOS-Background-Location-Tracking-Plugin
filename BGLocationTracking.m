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
    
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.delegate locationDidUpdate:newLocation];
    
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