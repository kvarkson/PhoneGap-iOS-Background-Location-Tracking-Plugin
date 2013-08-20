//
//  MyLocationUpdater.h
//  BGLocationTrackingPlugin
//
//  Created by Alex Shmaliy on 8/20/13.
//  Copyright (c) 2013 ASHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol MyLocationUpdaterDelegate <NSObject>
- (void)locationDidUpdate:(CLLocation *)newLocation;
- (void)locationDidFailWithError:(NSError *)error;
@end

@interface MyLocationUpdater : NSObject <CLLocationManagerDelegate>

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@property (nonatomic, unsafe_unretained) id <MyLocationUpdaterDelegate> delegate;

@end
