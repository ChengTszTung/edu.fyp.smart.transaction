//
//  ShopAnnotation.h
//  Smart Transaction
//
//  Created by TszTung Cheng on 23/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ShopAnnotation : NSObject<MKAnnotation>
@property (copy, nonatomic) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;


@end
