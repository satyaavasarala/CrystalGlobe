//
//  CryGloPredicationsData.h
//  CrystalGlobe
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryGloPredicationsData : NSObject

@property (strong, nonatomic)NSArray *quotes;
-(id)initWithQuotes;
-(NSString*)makePrediction;
@end
