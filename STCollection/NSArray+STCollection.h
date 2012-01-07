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
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              NSArray *result = [array arrayByRemovingObject:@"B"]; // [A, C]
 *              </pre>
 */
- (NSArray *)arrayByRemovingObject:(id)object;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              NSArray *result = [array reversedArray]; // [C, B, A]
 *              </pre>
 */
- (NSArray *)reversedArray;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [[A, B, C], [D, E]]
 *              NSArray *result = [array flattenedArray]; // [A, B, C, D, E]
 *              </pre>
 */
- (NSArray *)flattenedArray;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              NSArray *result = [array mappedArrayUsingBlock:^id(id object){
 *                  return [object stringByAppendingString:object];
 *              }]; // [AA, BB, CC]
 *              </pre>
 */
- (NSArray *)mappedArrayUsingBlock:(id (^)(id object))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              NSArray *result = [array filteredArrayUsingBlock:^BOOL(id object){
 *                  return ![object isEqualToString:@"B"];
 *              }]; // [A, C]
 *              </pre>
 */
- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id object))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              NSDictionary *result = [array groupedDictionaryUsingBlock:^id(id object){
 *                  return [object isEqualToString:@"A"] ? @"D" : @"E"];
 *              }]; // {D = [A], E = [B, C]}
 *              </pre>
 */
- (NSDictionary *)groupedDictionaryUsingBlock:(id (^)(id object))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array1 = ...; // [A, B, C]
 *              NSArray *array2 = ...; // [D, E, F]
 *              NSArray *result = [array1 zippedArrayWithArray:array2]; // [[A, D], [B, E], [C, F]]
 *              </pre>
 */
- (NSArray *)zippedArrayWithArray:(NSArray *)array;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [[A, D], [B, E], [C, F]]
 *              NSArray *result = [array unzippedArray]; // [A, B, C, D, E, F]
 *              </pre>
 */
- (NSArray *)unzippedArray;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              id result = [array valueByFoldingFromLeftWithInitialValue:@"Z"
 *                                                             usingBlock:^id(id left, id right) {
 *                  return [left stringByAppendingString:right];
 *              }]; // ZABC
 *              </pre>
 */
- (id)valueByFoldingFromLeftWithInitialValue:(id)value
                                  usingBlock:(id (^)(id left, id right))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              id result = [array valueByFoldingFromRightWithInitialValue:@"Z"
 *                                                              usingBlock:^id(id right, id left) {
 *                  return [right stringByAppendingString:left];
 *              }]; // ZCBA
 *              </pre>
 */
- (id)valueByFoldingFromRightWithInitialValue:(id)value
                                   usingBlock:(id (^)(id right, id left))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              id result = [array valueByReducingFromLeftUsingBlock:^id(id left, id right) {
 *                  return [left stringByAppendingString:right];
 *              }]; ABC
 *              </pre>
 */
- (id)valueByReducingFromLeftUsingBlock:(id (^)(id left, id right))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSArray *array = ...; // [A, B, C]
 *              id result = [array valueByReducingFromRightUsingBlock:^id(id right, id left) {
 *                  return [right stringByAppendingString:left];
 *              }]; // CBA
 *              </pre>
 */
- (id)valueByReducingFromRightUsingBlock:(id (^)(id right, id left))block;

@end
