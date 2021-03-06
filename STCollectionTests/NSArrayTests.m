// 
// Copyright (c) 2011, Shun Takebayashi
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
// 
// 1. Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
// 

#import <SenTestingKit/SenTestingKit.h>
#import <STCollection/NSArray+STCollection.h>

@interface NSArrayTests : SenTestCase {
    NSArray *_source;
}

@end

@implementation NSArrayTests

- (void)setUp {
    _source = [[NSArray alloc] initWithObjects:
               @"Cheetah",
               @"Puma",
               @"Jaguar",
               @"Panther",
               @"Tiger",
               @"Leopard",
               @"Snow Leopard",
               @"Lion",
               nil];
}

- (void)testRemove {
    NSArray *expected = [[NSArray alloc] initWithObjects:
                         @"Cheetah",
                         @"Puma",
                         @"Jaguar",
                         @"Panther",
                         @"Tiger",
                         @"Leopard",
                         @"Lion",
                         nil];
    NSArray *removed = [_source arrayByRemovingObject:@"Snow Leopard"];
    STAssertEqualObjects(removed,
                         expected,
                         @"Testing -[NSArray arrayByRemovingObject:]");
}

- (void)testReverse {
    NSArray *expected = [NSArray arrayWithObjects:
                         @"Lion",
                         @"Snow Leopard",
                         @"Leopard",
                         @"Tiger",
                         @"Panther",
                         @"Jaguar",
                         @"Puma",
                         @"Cheetah",
                         nil];
    NSArray *reversed = [_source reversedArray];
    STAssertEqualObjects(reversed,
                         expected,
                         @"Testing -[NSArray reversedArray]");
}

- (void)testFlatten {
    NSArray *source = [NSArray arrayWithObjects:
                       [_source subarrayWithRange:NSMakeRange(0, 5)],
                       [_source subarrayWithRange:NSMakeRange(5, 3)],
                       nil];
    NSArray *expected = _source;
    NSArray *flattened = [source flattenedArray];
    STAssertEqualObjects(flattened,
                         expected,
                         @"Testing -[NSArray flattenedArray]");
}

- (void)testMap {
    NSArray *expected = [NSArray arrayWithObjects:
                         @"Mac OS X Cheetah",
                         @"Mac OS X Puma",
                         @"Mac OS X Jaguar",
                         @"Mac OS X Panther",
                         @"Mac OS X Tiger",
                         @"Mac OS X Leopard",
                         @"Mac OS X Snow Leopard",
                         @"Mac OS X Lion",
                         nil];
    NSArray *mapped = [_source mappedArrayUsingBlock:^id(id object) {
        return [@"Mac OS X " stringByAppendingString:object];
    }];
    STAssertEqualObjects(mapped,
                         expected,
                         @"Testing -[NSArray mappedArrayUsingBlock:]");
}

- (void)testFilter {
    NSArray *expected = [NSArray arrayWithObjects:
                         @"Leopard", @"Snow Leopard", @"Lion", nil];
    NSArray *filtered = [_source filteredArrayUsingBlock:^BOOL(id object) {
        return [(NSString *)object rangeOfString:@"L"].location != NSNotFound;
    }];
    STAssertEqualObjects(filtered,
                         expected,
                         @"Testing -[NSArray filteredArrayUsingBlock:]");
}

- (void)testGroup {
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                              [_source subarrayWithRange:NSMakeRange(0, 5)], @"PowerPC",
                              [_source subarrayWithRange:NSMakeRange(5, 3)], @"Intel",
                              nil];
    NSDictionary *grouped = [_source groupedDictionaryUsingBlock:^id(id object) {
        if ([(NSString *)object isEqualToString:@"Leopard"] ||
            [(NSString *)object isEqualToString:@"Snow Leopard"] ||
            [(NSString *)object isEqualToString:@"Lion"]) {
            return @"Intel";
        }
        return @"PowerPC";
    }];
    STAssertEqualObjects(grouped,
                         expected,
                         @"Testing -[NSArray groupedDictionaryUsingBlock:]");
}

- (void)testZip {
    // zip
    NSArray *target = [NSArray arrayWithObjects:
                       @"10.0", 
                       @"10.1", 
                       @"10.2", 
                       @"10.3", 
                       @"10.4", 
                       @"10.5", 
                       @"10.6", 
                       @"10.7",
                       nil];
    NSArray *zipped = [_source zippedArrayWithArray:target];
    for (NSUInteger i = 0; i < [zipped count]; i++) {
        NSArray *extecped = [NSArray arrayWithObjects:
                         [_source objectAtIndex:i],
                         [target objectAtIndex:i],
                         nil];
        STAssertEqualObjects([zipped objectAtIndex:i],
                             extecped,
                             @"Testing pair of -[NSArray zippedArrayWithArray:]");
    }
    // unzip
    NSArray *unzipped = [zipped unzippedArray];
    NSArray *expectedUnzipped = [NSArray arrayWithObjects:_source, target, nil];
    STAssertEqualObjects(unzipped,
                         expectedUnzipped,
                         @"Testing -[NSArray unzippedArray]");
}

- (void)testFold {
    // foldLeft
    NSString *leftExpected = @"PB/Cheetah/Puma/Jaguar/Panther/Tiger/Leopard/Snow Leopard/Lion";
    NSString *leftReduced = [_source valueByFoldingFromLeftWithInitialValue:@"PB"
                                                                 usingBlock:^id(id left, id right) {
                                                                     return [(NSString *)left stringByAppendingFormat:@"/%@", right];
                                                                 }];
    STAssertEqualObjects(leftReduced,
                         leftExpected,
                         @"Testing -[NSArray valueByFoldingFromLeftWithInitialValue:usingBlock:]");
    // foldRight
    NSString *rightExpected = @"iOS/Lion/Snow Leopard/Leopard/Tiger/Panther/Jaguar/Puma/Cheetah";
    NSString *rightReduced = [_source valueByFoldingFromRightWithInitialValue:@"iOS"
                                                                   usingBlock:^id(id right, id left) {
                                                                       return [(NSString *)right stringByAppendingFormat:@"/%@", left];
                                                                   }];
    STAssertEqualObjects(rightReduced,
                         rightExpected,
                         @"Testing -[NSArray valueByFoldingFromRightWithInitialValue:usingBlock:]");
}

- (void)testReduce {
    // reduceLeft
    NSString *leftExpected = @"Cheetah/Puma/Jaguar/Panther/Tiger/Leopard/Snow Leopard/Lion";
    NSString *leftReduced = [_source valueByReducingFromLeftUsingBlock:^id(id left, id right) {
        return [(NSString *)left stringByAppendingFormat:@"/%@", right];
    }];
    STAssertEqualObjects(leftReduced,
                         leftExpected,
                         @"Testing -[NSArray valueByReducingFromLeftUsingBlock:]");
    // reduceRight
    NSString *rightExpected = @"Lion/Snow Leopard/Leopard/Tiger/Panther/Jaguar/Puma/Cheetah";
    NSString *rightReduced = [_source valueByReducingFromRightUsingBlock:^id(id right, id left) {
        return [(NSString *)right stringByAppendingFormat:@"/%@", left];
    }];
    STAssertEqualObjects(rightReduced,
                         rightExpected,
                         @"Testing -[NSArray valueByReducingFromRightUsingBlock:]");
}

@end
