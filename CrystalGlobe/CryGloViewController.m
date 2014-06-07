//
//  CryGloViewController.m
//  CrystalGlobe
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import "CryGloViewController.h"

@interface CryGloViewController ()

@end

@implementation CryGloViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Initialize the quotes array. All the predictions the app shows will be read from here.
    self.quotes = [[NSArray alloc] initWithObjects:
                   @"It is Certain",
                   @"It is Decidedly so",
                   @"All signs say YES",
                   @"The stars are not aligned",
                   @"My reply is no",
                   @"It is doubtful",
                   @"Better not tell you now",
                   @"Concentrate and ask again",
                   @"Unable to answer now", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)predictButtonPressed:(id)sender {
    int randomNumber = arc4random_uniform(9);
    self.predictionLabel.text=[self.quotes objectAtIndex:randomNumber];
}
@end
