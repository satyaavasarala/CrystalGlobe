//
//  CryGloViewController.h
//  CrystalGlobe
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CryGloPredicationsData;

@interface CryGloViewController : UIViewController
- (IBAction)predictButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *predictionLabel;
@property (strong, nonatomic) CryGloPredicationsData *predict;
@end
