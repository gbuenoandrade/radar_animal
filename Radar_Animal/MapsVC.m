//
//  MapsVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "MapsVC.h"
#import <CoreLocation/CoreLocation.h>
#import "InsertionVC.h"

@interface MapsVC () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D touchMapCoordinate;

@end

@implementation MapsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
	NSLog(@"EH TOEEES: %d",self.x);
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if(self.currentAnnotation){
		[self.mapView addAnnotation:self.currentAnnotation];
	}
	
	
	UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
	
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    self.touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
	
	[self performSegueWithIdentifier:@"goToInsertionScreen" sender:nil];
	

}

#pragma mark - MapDelegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	
    static NSString *AnnotationViewID = @"annotationViewID";
	
    MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
	
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    }
	
    UIImage *imgPinBorder = [UIImage imageNamed:@"mapicon"];
    UIImageView *imageViewPinBorder = [[UIImageView alloc] initWithImage:imgPinBorder];
    imageViewPinBorder.center = annotationView.center;
    [annotationView addSubview:imageViewPinBorder];
	
    UIImage *img = [UIImage imageNamed:@"mapicon"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:img];
    imageView.center = annotationView.center;
	
    annotationView.annotation = annotation;
	annotationView.canShowCallout = YES;
    annotationView.draggable = NO;
	annotationView.rightCalloutAccessoryView = imageView;
	
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{

}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"goToInsertionScreen"]){
		InsertionVC *nextVC = (InsertionVC*)[segue destinationViewController];
		nextVC.coordinate = self.touchMapCoordinate;
		nextVC.lastVC = self;
	}
}


@end
