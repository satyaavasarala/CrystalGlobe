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
#import <Masonry/Masonry.h>

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

    // Constraints for Predict Button. Must be 20pts from the bottom of the screen and horizontally aligned to center
    [self.predictButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20.0f);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    // Constraints for Background ImageView with its all sides same as Window.
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    // Constraints for Prediction Label for centerX and centerY equal to that of backgroundImage.
    [self.predictionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundImageView.mas_centerX);
        make.centerY.equalTo(self.backgroundImageView.mas_centerY);
    }];
}

@end
