//
//  GVPisteCyclable.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GVPoint;

@interface GVPisteCyclable : NSManagedObject

@property (nonatomic, retain) NSString * codeID;
@property (nonatomic) BOOL direc_uniq;
@property (nonatomic, retain) NSString * entiteID;
@property (nonatomic) float largeur;
@property (nonatomic) float longueur;
@property (nonatomic, retain) NSString * munID;
@property (nonatomic, retain) NSString * proprio;
@property (nonatomic, retain) NSString * revetement;
@property (nonatomic) BOOL route_verte;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *geom;
@end

@interface GVPisteCyclable (CoreDataGeneratedAccessors)

- (void)addGeomObject:(GVPoint *)value;
- (void)removeGeomObject:(GVPoint *)value;
- (void)addGeom:(NSSet *)values;
- (void)removeGeom:(NSSet *)values;

@end
