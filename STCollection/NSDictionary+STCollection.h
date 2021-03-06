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

@interface NSDictionary (STCollection)

/*!
 * @discussion  Example:
 *              <pre>
 *              NSDictionary *dictionary = ...; // {A = B, C = D, E = F}
 *              BOOL result = [dictionary hasKey:@"D"]; // NO
 *              </pre>
 */
- (BOOL)hasKey:(id)key;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSDictionary *dictionary = ...; // {A = B, C = D, E = F}
 *              NSDictionary *result = [dictionary dictionaryByAddingObject:@"H"
 *                                                                   forKey:@"G"]; // {A = B, C = D, E = F, G = H}
 *              </pre>
 */
- (NSDictionary *)dictionaryByAddingObject:(id)object forKey:(id)key;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSDictionary *dictionary = ...; // {A = B, C = D, E = F}
 *              NSDictionary *result1 = [dictionary dictionaryByAddingObject:@"H"
 *                                                           forUndefinedKey:@"G"]; // {A = B, C = D, E = F, G = H}
 *              NSDictionary *result2 = [dictionary dictionaryByAddingObject:@"X"
 *                                                           forUndefinedKey:@"G"]; // {A = B, C = D, E = F, G = H}
 *                                                                                  // G is already defined!
 *              </pre>
 */
- (NSDictionary *)dictionaryByAddingObject:(id)object forUndefinedKey:(id)key;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSDictionary *dictionary = ...; // {A = B, C = D, E = F}
 *              NSDictionary *result = [dictionary mappedDictionaryUsingBlock:^id(id key, id value) {
 *                  return [key stringByAppendingString:value];
 *              }]; // {A = AB, C = CD, E = EF}
 *              </pre>
 */
- (NSDictionary *)mappedDictionaryUsingBlock:(id (^)(id key, id value))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSDictionary *dictionary = ...; // {A = B, C = D, E = F}
 *              NSArray *results = [dictionary mappedArrayUsingBlock:^id(id key, id value) {
 *                  return [key stringByAppendingString:value];
 *              }]; // [AB, CD, EF]
 *              </pre>
 */
- (NSArray *)mappedArrayUsingBlock:(id (^)(id key, id value))block;

/*!
 * @discussion  Example:
 *              <pre>
 *              NSDictionary *dictionary = ...; // {A = B, C = D, E = F}
 *              NSDictionary *result = [dictionary filteredDictionaryUsingBlock:^BOOL(id key, id value) {
 *                  return ![key isEqualToString:"C"];
 *              }]; // {A = B, E = F}
 *              </pre>
 */
- (NSDictionary *)filteredDictionaryUsingBlock:(BOOL (^)(id key, id value))block;

@end
