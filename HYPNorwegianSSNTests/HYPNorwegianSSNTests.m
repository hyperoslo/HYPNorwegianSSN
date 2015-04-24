@import Cocoa;
@import XCTest;
#import "HYPNorwegianSSN.h"

@interface HYPNorwegianSSNTests : XCTestCase

@property (nonatomic, strong) HYPNorwegianSSN *SSN;

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

- (void)testSSNValidation
{
    XCTAssertTrue([HYPNorwegianSSN validateWithString:@"01015000232"]);
}

- (void)testAgePresence
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertGreaterThan([ssn.age integerValue], 0);
}

- (void)testAgeCalculation
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertEqualObjects(ssn.age, @65);
}

- (void)testIfFemale
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertTrue(ssn.isFemale);
}

- (void)testIfMale
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertFalse(ssn.isMale);
}

- (void)testDNumber
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertFalse(ssn.isDNumber);
}

- (void)testDateOfBirthString
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertEqualObjects(ssn.dateOfBirthString, @"010150");
}

- (void)testDateOfBirthStringWithCentury
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];

    XCTAssertEqualObjects(ssn.dateOfBirthStringWithCentury, @"01011950");
}

- (void)testBirthdate
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01015000232"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"ddMMyyyy";
    NSDate *date = [formatter dateFromString:ssn.dateOfBirthStringWithCentury];

    XCTAssertNotNil(date);

    NSDate *expectedDate = [formatter dateFromString:@"01011950"];

    XCTAssertEqualObjects(date, expectedDate);
}

- (void)testAgeDateConversion
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"14028949546"];

    // This guy's birthday is on Valentines day. So remember to give your
    // significant other a rose, and tell this guy happy birthday.
    // Or you can just update the thing to use a fix date.
    XCTAssertEqualObjects(ssn.age, @26);
}

- (void)testStringRangeSafety
{
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"11"];

    XCTAssertFalse(ssn.isValid);

    XCTAssertNil([ssn dateOfBirthString]);
}

- (void)testSSNInTwentyFirstCenturyAtEndOfRange {
    HYPNorwegianSSN *ssn = [[HYPNorwegianSSN alloc] initWithString:@"01030099911"];

    XCTAssertTrue(ssn.isValid);
    XCTAssertEqualObjects(ssn.dateOfBirthStringWithCentury, @"01032000");
}

@end
