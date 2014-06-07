//
//  CryGloViewController.m
//  CrystalGlobe
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import "CryGloViewController.h"
#import "CryGloPredicationsData.h"

@interface CryGloViewController ()

@end

@implementation CryGloViewController

#pragma mark View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Initialize the model array here. All the predictions the app shows will be read from here.
     self.predict = [[CryGloPredicationsData alloc] initWithQuotes];
    
}

#pragma mark Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Target-Action
- (IBAction)predictButtonPressed:(id)sender {
    [self setPrediction];
}


#pragma mark Motion Events
-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(event.subtype == UIEventSubtypeMotionShake) {
        [self resetPrediction];
    }
}

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if(event.subtype == UIEventSubtypeMotionShake) {
       [self setPrediction];
    }
}

-(void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

#pragma mark Utility Methods
-(void)setPrediction {
    self.predictionLabel.text=[self.predict makePrediction];
}

-(void)resetPrediction {
    self.predictionLabel.text=nil;
}





@end
