//
//  GVPoint.h
//  GatineauVélo
//
//  Created by Philippe on 2014-02-23.
//  Copyright (c) 2014 Philippe Casgrain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GVPoint : NSManagedObject

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end
