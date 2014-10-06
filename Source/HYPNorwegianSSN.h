//
//  HYPNorwegianSSN.h
//  HYPNorwegianSSN
//
//  Created by Christoffer Winterkvist on 10/5/14.
//
//

#import <Foundation/Foundation.h>

@interface HYPNorwegianSSN : NSObject

// SSNNineteenthCenturyType         = 000-499 (1900–1999)
// SSNTwentiethCenturyType          = 500–749 (1854–1899)
// SSNTwentiethFirstCenturyType     = 500-999 (2000–2039)
// SSNTwentiethCenturyAlternateType = 900-999 (1940–1999)

typedef NS_ENUM(NSInteger, SSNCenturyType) {
    SSNDefaultCenturyType = 0,
    SSNNineteenthCenturyType,
    SSNTwentiethCenturyType,
    SSNTwentyFirstCenturyType,
    SSNTwentiethCenturyAlternateType
};

@property (nonatomic, strong) NSString *SSN;
@property (nonatomic, readonly) NSUInteger age;
@property (nonatomic, readonly, getter=isDNumber) BOOL DNumber;
@property (nonatomic, readonly, getter=isFemale) BOOL female;
@property (nonatomic, readonly, getter=isMale)   BOOL male;
@property (nonatomic, readonly, getter=isValid)  BOOL valid;

- (instancetype)initWithSSN:(NSString *)string;

@end
