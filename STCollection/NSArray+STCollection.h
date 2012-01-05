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

#import <Foundation/Foundation.h>

@interface NSArray (STCollection)

/*!
 * @discussion  [A, B, C] => [A, C]
 */
- (NSArray *)arrayByRemovingObject:(id)object;

/*!
 * @discussion  [A, B, C] => [C, B, A]
 */
- (NSArray *)reversedArray;

/*!
 * @discussion  [[A, B, C], [D, E]] => [A, B, C, D, E]
 */
- (NSArray *)flattenedArray;

/*!
 * @discussion  [A, B, C] f() => [f(A), f(B), f(C)]
 */
- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block;

- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id object))block;

/*!
 * @discussion  [A, B, C] f() => {D = [A, B], E = [C]}
 */
- (NSDictionary *)groupedDictionaryUsingBlock:(id (^)(id object))block;

/*!
 * @discussion  [A, B, C] [D, E, F] => [[A, D], [B, E], [C, F]]
 */
- (NSArray *)zippedArrayWithArray:(NSArray *)array;

/*!
 * @discussion  [[A, D], [B, E], [C, F]] => [A, B, C] [D, E, F]
 */
- (NSArray *)unzippedArray;

/*!
 * @discussion  [A, B, C] Z f() => f[C, f[B, f[A, Z]]]
 */
- (id)valueByFoldingFromLeftWithInitialValue:(id)value
                                  usingBlock:(id (^)(id left, id right))block;

/*!
 * @discussion  [A, B, C] Z f() => f[f[f[Z, C], B], A]
 */
- (id)valueByFoldingFromRightWithInitialValue:(id)value
                                   usingBlock:(id (^)(id right, id left))block;

/*!
 * @discussion  [A, B, C] f() => f[C, f[B, A]]
 */
- (id)valueByReducingFromLeftUsingBlock:(id (^)(id left, id right))block;

/*!
 * @discussion  [A, B, C] f() => f[f[C, B], A]
 */
- (id)valueByReducingFromRightUsingBlock:(id (^)(id right, id left))block;

@end
