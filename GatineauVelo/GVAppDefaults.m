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
@property (strong) NSUserDefaults *defaults;

@end

@implementation GVAppDefaults

- (instancetype)initWithUserDefaults:(NSUserDefaults *)defaults
{
    if (self = [super init])
    {
        NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"ApplicationDefaults" withExtension:@"plist"];
        _appDefaults = [NSDictionary dictionaryWithContentsOfURL:url];
        _defaults = defaults;
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

    NSArray *colors = self.appDefaults[name];
    if (colors)
    {
        NSUInteger idx = [self.defaults integerForKey:name];
        if (idx < colors.count)
        {
            NSString *colorString = colors[idx];
            color = [UIColor colorWithHexString:colorString];
        }
    }

    return color;
}

- (NSArray *)colorsForName:(NSString *)name
{
    return self.appDefaults[name];
}

- (void)saveColorIndex:(NSUInteger)index forColorName:(NSString *)name
{
    [self.defaults setInteger:index forKey:name];
}

- (NSString *)csvFileName
{
    return self.appDefaults[@"csvFileName"];
}

@end
