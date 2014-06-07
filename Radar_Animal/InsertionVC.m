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

@interface InsertionVC () <UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *speciesTextField;
@property (weak, nonatomic) IBOutlet UITextField *raceTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UILabel *localizationLabel;

@end

@implementation InsertionVC

- (IBAction)selectPhoto:(id)sender {
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)backToMaps:(id)sender {
		
	
	
	Annotation *annotation = [[Annotation alloc] init];
	annotation.customTitle = [NSString stringWithFormat:@"%@ %@, %@",self.speciesTextField.text, self.raceTextField.text, self.nameTextField.text];
	annotation.coordinate = self.coordinate;
	
	NSLog(@"TA SETADA A BOMBA");
	self.lastVC.x = 789;
	
	
	[self dismissModalViewControllerAnimated:YES];

	
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.speciesTextField.delegate = self;
	self.raceTextField.delegate = self;
	self.nameTextField.delegate = self;
	
	self.localizationLabel.text = [NSString stringWithFormat:@"%.4f, %.4f",self.coordinate.latitude, self.coordinate.longitude];
}



@end
