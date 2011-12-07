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

#import "NSArray+STCollection.h"

@implementation NSArray (STCollection)

- (NSArray *)reversedArray {
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)flattenedArray {
    NSMutableArray *flattened = [NSMutableArray array];
    for (NSArray *subarray in self) {
        [flattened addObjectsFromArray:subarray];
    }
    return flattened;
}

- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block {
    NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        [mappedArray addObject:block(item)];
    }
    return mappedArray;
}

- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id object))block {
    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:[self count]];
    for (id item in self) {
        if (block(item)) {
            [filteredArray addObject:item];
        }
    }
    return filteredArray;
}

- (NSDictionary *)groupedDictionaryUsingBlock:(id (^)(id object))block {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:[self count]];
    for (id item in self) {
        id key = block(item);
        NSMutableArray *values = [dictionary objectForKey:key];
        if (!values) {
            values = [NSMutableArray array];
            [dictionary setObject:values forKey:key];
        }
        [values addObject:item];
    }
    return dictionary;
}

- (id)valueByFoldingFromLeftWithInitialValue:(id)value
                                  usingBlock:(id (^)(id left, id right))block {
    NSArray *array = [[NSArray arrayWithObject:value] arrayByAddingObjectsFromArray:self];
    return [array valueByReducingFromLeftUsingBlock:block];
}

- (id)valueByFoldingFromRightWithInitialValue:(id)value
                                   usingBlock:(id (^)(id right, id left))block {
    NSArray *array = [self arrayByAddingObject:value];
    return [array valueByReducingFromRightUsingBlock:block];
}

- (id)valueByReducingFromLeftUsingBlock:(id (^)(id left, id right))block {
    id result;
    for (NSUInteger i = 0; i < self.count; i++) {
        id item = [self objectAtIndex:i];
        if (i == 0) {
            result = item;
        }
        else {
            result = block(result, item);
        }
    }
    return result;
}

- (id)valueByReducingFromRightUsingBlock:(id (^)(id right, id left))block {
    NSArray *array = [[self reverseObjectEnumerator] allObjects];
    return [array valueByReducingFromLeftUsingBlock:block];
}

@end
