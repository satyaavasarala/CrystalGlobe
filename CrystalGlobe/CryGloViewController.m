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
    
    
    NSMutableArray *images = [[NSMutableArray alloc] init];

    for (int i=1; i<=60; i++) {
        UIImage *image;
        if(i<10) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"CB0000%d",i]];
        }else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"CB000%d",i]];
        }
        [images addObject:image];
    }
    [self.backgroundImageView setAnimationImages:images];
    [self.backgroundImageView setAnimationDuration:2.5f];
    [self.backgroundImageView setAnimationRepeatCount:1];
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
