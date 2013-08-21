//
//  BGLocationTracking.m
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  MIT Licensed
//

#import "BGLocationTracking.h"

@interface BGLocationTracking ()

- (void)reInitAndStartLocationManager;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CDVInvokedUrlCommand *successCB;

@end


@implementation BGLocationTracking
@synthesize locationManager, delegate, successCB;

- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command {
    [self reInitAndStartLocationManager];
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

- (void)reInitAndStartLocationManager {
    
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [self.delegate locationDidUpdate:newLocation];
    
    [self callSuccessJSCalback:newLocation.coordinate.latitude :newLocation.coordinate.longitude];
    
    // stop location manager
    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    // TODO: need to re-init location manager with some delay
    [self reInitAndStartLocationManager];
}

- (void)callSuccessJSCalback:(double)lat :(double)lon {
    [self.webView stringByEvaluatingJavaScriptFromString:
        [NSString stringWithFormat:@"%@({ coords: { latitude: %f, longitude: %f}});", self.successCB, lat, lon ]];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError: %@", error);
    
    [self.delegate locationDidFailWithError:error];

    [self stopUpdatingLocation:[[CDVInvokedUrlCommand alloc] init]];
    
    [self reInitAndStartLocationManager];
}

@end