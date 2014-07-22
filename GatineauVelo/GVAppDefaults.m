//
//  GVAppDefaults.m
//  GatineauVelo
//
//  Created by Philippe on 2014-03-01.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import "GVAppDefaults.h"
#import "UIColor+HexColors.h"

@interface GVAppDefaults()

@property (strong) NSDictionary *appDefaults;
@property (assign) MKCoordinateRegion maxCityRegionInternal;

@end

@implementation GVAppDefaults

- (instancetype)init
{
    if (self = [super init])
    {
        NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"ApplicationDefaults" withExtension:@"plist"];
        _appDefaults = [NSDictionary dictionaryWithContentsOfURL:url];
    }

    return self;
}

- (MKCoordinateRegion)maximumCityRegion
{
    if (self.maxCityRegionInternal.span.latitudeDelta == 0)
    {
        NSDictionary *cityExtent = self.appDefaults[@"cityExtent"];
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake([cityExtent[@"centerLat"] doubleValue], [cityExtent[@"centerLong"] doubleValue]);
        MKCoordinateSpan span = MKCoordinateSpanMake([cityExtent[@"deltaLat"] doubleValue], [cityExtent[@"deltaLong"] doubleValue]);
        self.maxCityRegionInternal = MKCoordinateRegionMake(center, span);
    }

    return self.maxCityRegionInternal;
}

- (UIColor *)colorNamed:(NSString *)name
{
    UIColor *color = [UIColor clearColor];

    NSString *colorString = self.appDefaults[name];
    if (colorString)
    {
        color = [UIColor colorWithHexString:colorString];
    }

    return color;
}

- (NSString *)csvFileName
{
    return self.appDefaults[@"csvFileName"];
}

@end
