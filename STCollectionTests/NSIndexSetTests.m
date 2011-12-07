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
#import <STCollection/NSIndexSet+STCollection.h>

@interface NSIndexSetTests : SenTestCase {
    NSIndexSet *_source;
}

@end

@implementation NSIndexSetTests

- (void)setUp {
    _source = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)];
}

- (void)testIndexes {
    NSArray *indexes = [_source indexes];
    NSMutableArray *expected = [NSMutableArray arrayWithCapacity:10];
    for (NSUInteger i = 0; i < 10; i++) {
        [expected addObject:[NSNumber numberWithUnsignedInteger:i]];
    }
    STAssertEqualObjects(indexes,
                         expected,
                         @"Testing -[NSIndexSet indexes]");
}

- (void)testMap {
    NSMutableIndexSet *expected = [NSMutableIndexSet indexSet];
    for (NSUInteger i = 0; i < 10; i++) {
        [expected addIndex:i * i];
    }
    NSIndexSet *mapped = [_source mappedIndexSetUsingBlock:^NSUInteger(NSUInteger index) {
        return index * index;
    }];
    STAssertEqualObjects(mapped,
                         expected,
                         @"Testing -[NSIndexSet mappedIndexSetUsingBlock:]");
}

@end
