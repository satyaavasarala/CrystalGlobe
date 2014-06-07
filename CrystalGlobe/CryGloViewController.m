//
//  CryGloViewController.m
//  CrystalGlobe
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import "CryGloViewController.h"
#import "CryGloPredicationsData.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CryGloViewController ()

@end

@implementation CryGloViewController {
    SystemSoundID soundEffect;
}

#pragma mark View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setting the sound
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"crystal_ball" ofType:@"mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID(CFBridgingRetain(soundURL), &soundEffect);
    
    
	// Initialize the model array here. All the predictions the app shows will be read from here.
    self.predict = [[CryGloPredicationsData alloc] initWithQuotes];
    
    // Prepare Background Image View to appear
    [self prepareBackgroundImageView];
    
    // Prepare Predict Button
    [self preparePredictButton];
    
    //Prepare Prediction Label
    [self preparePredictionLabel];
    
    // set constraints
    [self setConstrainsts];
}


#pragma mark Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Target-Action
- (IBAction)predictButtonPressed:(id)sender {
    [self resetPrediction];
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
    [self.backgroundImageView startAnimating];
    self.predictionLabel.text=[self.predict makePrediction];
    AudioServicesPlaySystemSound(soundEffect);
    
    [UIView animateWithDuration:6.0 animations:^{
        self.predictionLabel.alpha = 1.0f;
    }];
}

-(void)resetPrediction {
    self.predictionLabel.alpha=0.0f;
}


#pragma mark Views Preparation Methods

-(void)prepareBackgroundImageView {
    self.backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CB00001"]];
    [self.backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.backgroundImageView setFrame:CGRectMake(0, 0, 320, 568)];
    
    self.backgroundImageView.animationImages = [[NSArray alloc] initWithObjects:
                                                [UIImage imageNamed:@"CB00001"],
                                                [UIImage imageNamed:@"CB00002"],
                                                [UIImage imageNamed:@"CB00003"],
                                                [UIImage imageNamed:@"CB00004"],
                                                [UIImage imageNamed:@"CB00005"],
                                                [UIImage imageNamed:@"CB00006"],
                                                [UIImage imageNamed:@"CB00007"],
                                                [UIImage imageNamed:@"CB00008"],
                                                [UIImage imageNamed:@"CB00009"],
                                                [UIImage imageNamed:@"CB00010"],
                                                [UIImage imageNamed:@"CB00011"],
                                                [UIImage imageNamed:@"CB00012"],
                                                [UIImage imageNamed:@"CB00013"],
                                                [UIImage imageNamed:@"CB00014"],
                                                [UIImage imageNamed:@"CB00015"],
                                                [UIImage imageNamed:@"CB00016"],
                                                [UIImage imageNamed:@"CB00017"],
                                                [UIImage imageNamed:@"CB00018"],
                                                [UIImage imageNamed:@"CB00019"],
                                                [UIImage imageNamed:@"CB00020"],
                                                [UIImage imageNamed:@"CB00021"],
                                                [UIImage imageNamed:@"CB00022"],
                                                [UIImage imageNamed:@"CB00023"],
                                                [UIImage imageNamed:@"CB00024"],
                                                [UIImage imageNamed:@"CB00025"],
                                                [UIImage imageNamed:@"CB00026"],
                                                [UIImage imageNamed:@"CB00027"],
                                                [UIImage imageNamed:@"CB00028"],
                                                [UIImage imageNamed:@"CB00029"],
                                                [UIImage imageNamed:@"CB00030"],
                                                [UIImage imageNamed:@"CB00031"],
                                                [UIImage imageNamed:@"CB00032"],
                                                [UIImage imageNamed:@"CB00033"],
                                                [UIImage imageNamed:@"CB00034"],
                                                [UIImage imageNamed:@"CB00035"],
                                                [UIImage imageNamed:@"CB00036"],
                                                [UIImage imageNamed:@"CB00037"],
                                                [UIImage imageNamed:@"CB00038"],
                                                [UIImage imageNamed:@"CB00039"],
                                                [UIImage imageNamed:@"CB00040"],
                                                [UIImage imageNamed:@"CB00041"],
                                                [UIImage imageNamed:@"CB00042"],
                                                [UIImage imageNamed:@"CB00043"],
                                                [UIImage imageNamed:@"CB00044"],
                                                [UIImage imageNamed:@"CB00045"],
                                                [UIImage imageNamed:@"CB00046"],
                                                [UIImage imageNamed:@"CB00047"],
                                                [UIImage imageNamed:@"CB00048"],
                                                [UIImage imageNamed:@"CB00049"],
                                                [UIImage imageNamed:@"CB00050"],
                                                [UIImage imageNamed:@"CB00051"],
                                                [UIImage imageNamed:@"CB00052"],
                                                [UIImage imageNamed:@"CB00053"],
                                                [UIImage imageNamed:@"CB00054"],
                                                [UIImage imageNamed:@"CB00055"],
                                                [UIImage imageNamed:@"CB00056"],
                                                [UIImage imageNamed:@"CB00057"],
                                                [UIImage imageNamed:@"CB00058"],
                                                [UIImage imageNamed:@"CB00059"],
                                                [UIImage imageNamed:@"CB00060"],nil];
    self.backgroundImageView.animationDuration = 2.5f;
    self.backgroundImageView.animationRepeatCount = 1;
    [self.view insertSubview:self.backgroundImageView atIndex:0];
}

-(void)preparePredictButton {
    self.predictButton = [[UIButton alloc] init];
    [self.predictButton setImage:[UIImage imageNamed:@"button-off"] forState:UIControlStateNormal];
    [self.predictButton setImage:[UIImage imageNamed:@"button-on"] forState:UIControlStateHighlighted];
    
    self.predictButton.frame = CGRectMake(0, 0, 241, 49);
    
    [self.predictButton addTarget:self
                           action:@selector(predictButtonPressed:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:self.predictButton atIndex:1];
}

-(void)preparePredictionLabel {
    self.predictionLabel = [[UILabel alloc] init];
    
    [self.predictionLabel setText:@"Crystall Globe Prediction"];
    [self.predictionLabel setTextColor:[[UIColor alloc] initWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f]];
    self.predictionLabel.frame = CGRectMake(0, 0, 241, 49);
    
    [self.view insertSubview:self.predictionLabel atIndex:2];
}

#pragma mark Constraints
-(void)setConstrainsts {
    self.predictButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.predictionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[
                                // Constraints for Prediction Button
                                [NSLayoutConstraint constraintWithItem:self.predictButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-20.0f
                                 ],
                                [NSLayoutConstraint constraintWithItem:self.predictButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f
                                ],
                                //Constraints for BackgroundImage
                                [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f
                                ],
                                [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f
                                ],
                                [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f
                                ],
                                [NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f
                                 ],
                                //Constraints for Predcition Label
                                [NSLayoutConstraint constraintWithItem:self.predictionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f
                                 ],
                                [NSLayoutConstraint constraintWithItem:self.predictionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f
                                 ]
                                ]
     ];
}

@end
