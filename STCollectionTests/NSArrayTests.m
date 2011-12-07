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
#import "NSArray+STCollection.h"

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

@end
