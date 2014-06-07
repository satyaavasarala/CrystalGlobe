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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Initialize the model array here. All the predictions the app shows will be read from here.
     self.predict = [[CryGloPredicationsData alloc] initWithQuotes];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)predictButtonPressed:(id)sender {
    self.predictionLabel.text=[self.predict makePrediction];
}
@end
