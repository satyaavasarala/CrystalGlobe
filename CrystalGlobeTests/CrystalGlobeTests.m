//
//  CrystalGlobeTests.m
//  CrystalGlobeTests
//
//  Created by Satya Avasarala on 6/7/14.
//  Copyright (c) 2014 com.satya. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CryGloPredicationsData.h"

@interface CrystalGlobeTests : XCTestCase

@end

@implementation CrystalGlobeTests

CryGloPredicationsData *predictions;
- (void)setUp
{
    [super setUp];
    predictions = [[CryGloPredicationsData alloc] initWithQuotes];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCryGloPredicationsDataNotNil
{
    XCTAssertNotNil(predictions, @"Initializing CryGloPredicationsData failed.");
}

-(void)testPredictionsIsString
{
    XCTAssertTrue([[predictions makePrediction] isKindOfClass:[NSString class]], @"Returned prediction is not a NSString");
}

-(void)testSizeOfQuotesArray
{
    XCTAssertEqual([predictions.quotes count], 9, "The number of strings in the quotes array is not equal to 9");
}

@end
