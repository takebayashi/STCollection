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
#import <STCollection/NSDictionary+STCollection.h>

@interface NSDictionaryTests : SenTestCase {
    NSDictionary *_source;
}

@end

@implementation NSDictionaryTests

- (void)setUp {
    _source = [NSDictionary dictionaryWithObjectsAndKeys:
               @"OSX", @"Mac",
               @"iOS", @"iPhone",
               nil];
}

- (void)testKey {
    STAssertTrue([_source hasKey:@"Mac"],
                 @"Testing -[NSDictionary hasKey:]");
    STAssertFalse([_source hasKey:@"Pipin"],
                  @"Testing -[NSDictionary hasKey:]");
}

- (void)testAdd {
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"OSX", @"Mac",
                              @"iOS", @"iPhone",
                              @"Atmark", @"Pipin",
                              nil];
    NSDictionary *added1 = [_source dictionaryByAddingObject:@"Atmark"
                                             forUndefinedKey:@"Pipin"];
    STAssertEqualObjects(added1,
                         expected,
                         @"Testing -[NSDictionary dictionaryByAddingObject:forUndefinedKey:");
    NSDictionary *added2 = [added1 dictionaryByAddingObject:@"None"
                                             forUndefinedKey:@"Pipin"];
    STAssertEqualObjects(added2,
                         expected,
                         @"Testing -[NSDictionary dictionaryByAddingObject:forUndefinedKey:");
}

- (void)testMap {
    NSDictionary *expected = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"Mac/OSX", @"Mac",
                              @"iPhone/iOS", @"iPhone",
                              nil];
    NSDictionary *mapped = [_source mappedDictionaryUsingBlock:^id(id key, id value) {
        return [NSString stringWithFormat:@"%@/%@", key, value];
    }];
    STAssertEqualObjects(mapped,
                         expected,
                         @"Testing -[NSDictionary mappedDictionaryUsingBlock:]");
}

@end
