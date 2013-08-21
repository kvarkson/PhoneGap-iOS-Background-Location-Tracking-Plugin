//
//  BGLocationTracking.m
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  MIT Licensed
//

#import "BGLocationTracking.h"

@interface BGLocationTracking ()

- (void)initAndStartLocationManager;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CDVInvokedUrlCommand *successCB;

@end


@implementation BGLocationTracking
@synthesize locationManager, delegate, successCB;

- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command {
    [self initAndStartLocationManager];
    self.successCB = [command.arguments objectAtIndex:0];
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
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 10.0;
    locationManager.activityType = CLActivityTypeFitness;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.delegate locationDidUpdate:newLocation];
    
    [self callSuccessJSCalback:newLocation.coordinate.latitude :newLocation.coordinate.longitude];
    
}

- (void)callSuccessJSCalback:(double)lat :(double)lon {
    [self.webView stringByEvaluatingJavaScriptFromString:
        [NSString stringWithFormat:@"%@({ coords: { latitude: %f, longitude: %f}});", self.successCB, lat, lon ]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    [self.delegate locationDidFailWithError:error];
    NSLog(@"%@", error);
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    [self initAndStartLocationManager];
}

@end