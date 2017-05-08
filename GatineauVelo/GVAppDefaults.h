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

- (instancetype)initWithUserDefaults:(NSUserDefaults *)defaults;

@property (readonly) MKCoordinateRegion maximumCityRegion;
@property (readonly) NSString *csvFileName;

- (UIColor *)colorNamed:(NSString *)name;
- (NSArray *)colorsForName:(NSString *)name;
- (void)saveColorIndex:(NSUInteger)index forColorName:(NSString *)name;

@end
