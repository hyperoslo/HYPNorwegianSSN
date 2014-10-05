//
//  HYPNorwegianSSNTests.m
//  HYPNorwegianSSNTests
//
//  Created by Christoffer Winterkvist on 10/5/14.
//
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "HYPNorwegianSSN.h"

static NSString *HYPBaseSSN = @"03129041853";

@interface HYPNorwegianSSNTests : XCTestCase

@property (nonatomic, strong) HYPNorwegianSSN *SSN;

@end

@implementation HYPNorwegianSSNTests

- (void)setUp
{
    [super setUp];

    self.SSN = [[HYPNorwegianSSN alloc] initWithSSN:HYPBaseSSN];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAgePresence
{


    XCTAssert((self.SSN.age > 0), @"Age is higher than zero");
}

- (void)testAgeCalculation
{
    XCTAssert((self.SSN.age == 24), @"Age is higher than zero");
}

- (void)testIfFemale
{
    XCTAssert(!self.SSN.isFemale, @"Is not Female");
}

- (void)testIfMale
{
    XCTAssert(self.SSN.isMale, @"Is male");
}

@end
