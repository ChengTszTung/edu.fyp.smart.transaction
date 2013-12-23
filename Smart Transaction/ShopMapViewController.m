//
//  ShopMapViewController.m
//  Smart Transaction
//
//  Created by TszTung Cheng on 23/12/13.
//  Copyright (c) 2013 1314-114102-02. All rights reserved.
//

#import "ShopMapViewController.h"
#import "ShopAnnotation.h"
@interface ShopMapViewController () {
    
    CLLocationCoordinate2D location;                         // coordinates of the annotation
    NSMutableArray *newAnnotations;   // an array in which we'll save our annotations temporarily
    ShopAnnotation *newAnnotation;                        // the pointer to the annotation we're adding
}

@end

@implementation ShopMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    _receivedData = [[NSMutableData alloc]init];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"http://icchserver.bugs3.com/Test/json_testing.php"]];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"received data");
    [_receivedData appendData:data]; //this is a NSMutableData
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *err;
    self.contactArr = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&err];
    
    if(err!=nil)
    {
        NSLog(@"Error!");
    } else {
        newAnnotations = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *dictionary in _contactArr)
        {
            // retrieve latitude and longitude from the dictionary entry
            
            location.latitude = [dictionary[@"lati"] doubleValue];
            location.longitude = [dictionary[@"long"] doubleValue];
            
            // create the annotation
            
            newAnnotation = [[ShopAnnotation alloc] init];
            [newAnnotation setTitle:dictionary[@"location"]];
            [newAnnotation setCoordinate:CLLocationCoordinate2DMake(location.latitude, location.longitude)];
            [newAnnotations addObject:newAnnotation];
            NSLog(@"location loading");
            NSLog(@"location : %@", dictionary[@"location"]);
            NSLog(@"lati : %@", dictionary[@"lati"]);
            NSLog(@"long : %@", dictionary[@"long"]);
            
        }
        NSLog(@"Array : %@", newAnnotations);
        [self.myMapView addAnnotations:newAnnotations];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //NSMutableArray *locArr = [[NSMutableArray alloc]init];
    
    //    MFAnnotation *newYork = [[MFAnnotation alloc]init];
    //    [newYork setTitle:@"New York"];
    //    [newYork setCoordinate:CLLocationCoordinate2DMake(40.30, -71.51)];
    //    [locArr addObject:newYork];
    //    MFAnnotation *hongKong = [[MFAnnotation alloc]init];
    //    [hongKong setTitle:@"Hong Kong"];
    //    [hongKong setCoordinate:CLLocationCoordinate2DMake(22.278, 114.158)];
    //    [locArr addObject:hongKong];
    //    MFAnnotation *teheran = [[MFAnnotation alloc]init];
    //    [teheran setTitle:@"Teheran"];
    //    [teheran setCoordinate:CLLocationCoordinate2DMake(35.696, 51.423)];
    //    [locArr addObject:teheran];
    //    MFAnnotation *sydney = [[MFAnnotation alloc]init];
    //    [sydney setTitle:@"Sydney"];
    //    [sydney setCoordinate:CLLocationCoordinate2DMake(-33.860, 151.211)];
    //    [locArr addObject:sydney];
    
    CLLocationCoordinate2D location;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 5000000, 5000000);
    MKCoordinateRegion adjustedRegion = [self.myMapView regionThatFits:viewRegion];
    [self.myMapView setRegion:adjustedRegion animated:YES];
    self.myMapView.showsUserLocation = YES;
    [_myMapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"city"];
    if(!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"city"];
    }
    [annotationView setCanShowCallout:YES];
    [annotationView setAnnotation:annotation];
    return annotationView;
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 1500, 1500);
    [mapView setRegion:region animated:YES];
}
@end
