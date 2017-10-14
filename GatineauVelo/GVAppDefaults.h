//
//  GVAppDefaults.h
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface GVAppDefaults : NSObject

@property (readonly) MKCoordinateRegion maximumCityRegion;
@property (readonly) NSString *csvFileName;
@property (readonly) NSString *updateFileName;

- (UIColor *)colorNamed:(NSString *)name;

@end
