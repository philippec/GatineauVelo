//
//  GVPoint.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GVPisteCyclable;

@interface GVPoint : NSManagedObject

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) GVPisteCyclable *piste;

@end
