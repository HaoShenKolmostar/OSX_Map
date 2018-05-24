/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Header file for this sample's main NSViewController.
 */

#import "MapViewController.h"
#import <MapKit/MapKit.h>

#import "CustomAnnotationView.h"    // annotation view for the Tea Carbon


@interface MapViewController () <MKMapViewDelegate>

@property (strong) IBOutlet MKMapView *mapView;

@property (strong) IBOutlet NSMatrix *annotationStates; // series of check boxes to hide/show annotations
@property (strong) IBOutlet NSTextFieldCell *txtLat;
@property (strong) IBOutlet NSTextFieldCell *txtLng;
@property (strong) IBOutlet NSTextFieldCell *txtHeading;
@property (strong) IBOutlet NSTextFieldCell *txtPitch;
@property (strong) NSMutableArray *mapAnnotations;

@end


#pragma mark -

@implementation MapViewController

+ (CGFloat)annotationPadding    { return 10.0f; }
+ (CGFloat)calloutHeight        { return 40.0f; }

- (void)gotoDefaultLocation
{
    double double_lat = [self.txtLat.stringValue doubleValue];
    double double_lng = [self.txtLng.stringValue doubleValue];
    double double_heading = [self.txtHeading.stringValue doubleValue];
    double double_pitch = [self.txtPitch.stringValue doubleValue];
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = double_lat;
    newRegion.center.longitude = double_lng;
    newRegion.span.latitudeDelta = 0.001;
    newRegion.span.longitudeDelta = 0.0005;
    [self.mapView setRegion:newRegion animated:NO];
    
    MKMapCamera *newCamera = [[self.mapView camera] copy];
    [newCamera setHeading:double_heading];
    [newCamera setPitch:double_pitch];
    [self.mapView setCamera:newCamera animated:NO];
}

- (void)awakeFromNib
{
    [self gotoDefaultLocation];    // go to San Francisco
    [self.mapView addAnnotations:self.mapAnnotations];
    [self.mapView setShowsZoomControls:YES];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsBuildings = true;
    self.mapView.showsScale = true;
    self.mapView.showsCompass = true;
    self.mapView.pitchEnabled = true;
}


#pragma mark - Action methods

- (IBAction)annotationsAction:(id)sender
{
    [self gotoDefaultLocation];
}


@end
