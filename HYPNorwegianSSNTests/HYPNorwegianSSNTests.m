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

@property (nonatomic, strong) HYPNorwegianSSN *ssn;

@end

@implementation HYPNorwegianSSNTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAgePresence
{
    self.ssn = [[HYPNorwegianSSN alloc] initWithSSN:HYPBaseSSN];

    XCTAssert((self.ssn.age > 0), @"Age is higher than zero");
}

- (void)testAgeCalculation
{
    self.ssn = [[HYPNorwegianSSN alloc] initWithSSN:HYPBaseSSN];

    XCTAssert((self.ssn.age == 24), @"Age is higher than zero");
}

@end
