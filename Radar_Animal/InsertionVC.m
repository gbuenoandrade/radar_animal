//
//  InsertionVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "InsertionVC.h"
#import "Annotation.h"
#import "MapsVC.h"

@interface InsertionVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UITextField *raceTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UILabel *localizationLabel;

@end

@implementation InsertionVC


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	self.speciesTextField.delegate = self;
	self.raceTextField.delegate = self;
	self.nameTextField.delegate = self;
	
	self.localizationLabel.text = [NSString stringWithFormat:@"%.4f, %.4f",self.coordinate.latitude, self.coordinate.longitude];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if([segue.identifier isEqualToString:@"backToMaps"]){
		Annotation *annotation = [[Annotation alloc] init];
		annotation.customTitle = [NSString stringWithFormat:@"%@ %@, %@",self.speciesTextField.text, self.raceTextField.text, self.nameTextField.text];
		annotation.coordinate = self.coordinate;
		
		MapsVC *nextVC = (MapsVC*)[segue destinationViewController];
		nextVC.currentAnnotation = annotation;
	}
}


@end
