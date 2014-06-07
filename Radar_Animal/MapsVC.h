//
//  MapsVC.h
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Annotation;


@interface MapsVC : UIViewController

@property (strong, nonatomic) id<MKAnnotation> currentAnnotation;


@property (nonatomic) NSInteger x;

@end
