//
//  CryGloPredicationsData.m
//  CrystalGlobe
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import "CryGloPredicationsData.h"

@implementation CryGloPredicationsData

-(id)initWithQuotes{
    self.quotes = [[NSArray alloc] initWithObjects:
                   @"It is Certain",
                   @"It is Decidedly so",
                   @"All signs say YES",
                   @"The stars are aligned",
                   @"My reply is no",
                   @"It is doubtful",
                   @"Better not tell you now",
                   @"Concentrate and ask again",
                   @"Unable to answer now",nil];
    return self;
}

-(NSString*)makePrediction{
    int randomNumber = arc4random_uniform(9);
    NSString *prediction=[self.quotes objectAtIndex:randomNumber];
    return prediction;
}

@end
