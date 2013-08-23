//
//  BGLocationTracking.m
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  MIT Licensed
//

#import "BGLocationTracking.h"

#define LOCATION_MANAGER_LIFETIME_MAX (14 * 60) // in seconds

@interface BGLocationTracking ()

- (void)initAndStartLocationManager;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CDVInvokedUrlCommand *successCB;
@property (strong, nonatomic) CDVInvokedUrlCommand *errorCB;
@property (strong, nonatomic) NSDate *locationManagerCreationDate;

@end


@implementation BGLocationTracking
@synthesize locationManager, delegate, successCB, errorCB;
@synthesize locationManagerCreationDate;

- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command {
    [self initAndStartLocationManager];
    self.successCB = [command.arguments objectAtIndex:0];
    self.errorCB = [command.arguments objectAtIndex:1];
}

- (void)stopUpdatingLocation:(CDVInvokedUrlCommand *)command {
    //NSLog(@"stopUpdatingLocation");
    
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
        self.locationManager = nil;
    }
}

- (void)initAndStartLocationManager {
    
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManagerCreationDate = [NSDate date];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 10.0;
    locationManager.activityType = CLActivityTypeFitness;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.delegate locationDidUpdate:newLocation];
    
    [self callSuccessJSCalback:newLocation];
    
    // if location manager is very old, need to re-init
    NSDate *currentDate = [NSDate date];
    if ([currentDate timeIntervalSinceDate:self.locationManagerCreationDate] >= LOCATION_MANAGER_LIFETIME_MAX) {
        [self initAndStartLocationManager];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [self.delegate locationDidFailWithError:error];
    [self callErrorJSCalback:error];
    
    [self initAndStartLocationManager];
}

- (void)callSuccessJSCalback:(CLLocation *)location {
    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"%@({ coords: { latitude: %f, longitude: %f}});", self.successCB, location.coordinate.latitude, location.coordinate.longitude ]];
}

- (void)callErrorJSCalback:(NSError *)error {
    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:@"%@({ message: '%@' });", self.errorCB, error.localizedDescription ]];
}

@end