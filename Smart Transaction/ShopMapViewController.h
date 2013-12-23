//
//  ShopMapViewController.h
//  Smart Transaction
//
//  Created by TszTung Cheng on 23/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface ShopMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) NSMutableData* receivedData;
@property (strong, nonatomic) NSArray* contactArr;

@end