//
//  BGLocationTracking.h
//  BGLocationTracking
//
//  Created by Alex Shmaliy on 8/20/13.
//  MIT Licensed
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Cordova/CDVPlugin.h>

@interface BGLocationTracking : CDVPlugin <CLLocationManagerDelegate>

- (void)startUpdatingLocation:(CDVInvokedUrlCommand *)command;
- (void)stopUpdatingLocation:(CDVInvokedUrlCommand *)command;

@end
