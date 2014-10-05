//
//  HYPNorwegianSSN.h
//  HYPNorwegianSSN
//
//  Created by Christoffer Winterkvist on 10/5/14.
//
//

#import <Foundation/Foundation.h>

@interface HYPNorwegianSSN : NSObject

@property (nonatomic, readonly) NSUInteger age;
@property (nonatomic, readonly, getter=isDNumber) BOOL DNumber;
@property (nonatomic, readonly, getter=isFemale) BOOL female;
@property (nonatomic, readonly, getter=isMale)   BOOL male;
@property (nonatomic, readonly, getter=isValid)  BOOL valid;

@end
