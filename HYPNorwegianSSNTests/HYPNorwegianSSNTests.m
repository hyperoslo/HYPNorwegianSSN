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

static NSString *HYPBaseSSN = @"01015000232";

@interface HYPNorwegianSSNTests : XCTestCase

@property (nonatomic, strong) HYPNorwegianSSN *SSN;

@end

@implementation HYPNorwegianSSNTests

- (void)setUp
{
    [super setUp];

    self.SSN = [[HYPNorwegianSSN alloc] initWithString:HYPBaseSSN];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSSNValidation
{
    XCTAssert(self.SSN.valid, @"SSN is valid");
}

- (void)testAgePresence
{
    XCTAssert(([self.SSN.age integerValue] > 0), @"Age is higher than zero");
}

- (void)testAgeCalculation
{
    XCTAssert(([self.SSN.age isEqualToNumber:@64]), @"Age is higher than zero");
}

- (void)testIfFemale
{
    XCTAssert(self.SSN.isFemale, @"Is Female");
}

- (void)testIfMale
{
    XCTAssert(!self.SSN.isMale, @"Is not Male");
}

- (void)testDNumber
{
    XCTAssert(!self.SSN.isDNumber, @"Is not D-Number (not a party swede, thank god)");
}

- (void)testDateOfBirthString
{
    XCTAssert([self.SSN.dateOfBirthString isEqualToString:@"010150"], @"Sucessfully extracted date of birth");
}

- (void)testDateOfBirthStringWithCentury
{
    XCTAssert([self.SSN.dateOfBirthStringWithCentury isEqualToString:@"01011950"], @"Sucessfully extracted date of birth");
}

- (void)testBirthdate
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"DDMMyyyy";
    NSDate *date = [formatter dateFromString:self.SSN.dateOfBirthStringWithCentury];

    XCTAssert(date, @"Date of birth is an NSDate");
}

- (void)testAgeDateConversion
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"14028849959"];
    XCTAssert(([ssn.age isEqualToNumber:@26]), @"Age is %@", [ssn.age stringValue]);
}

@end
