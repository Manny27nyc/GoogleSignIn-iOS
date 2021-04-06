/*
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// The options used internally for aspects of the sign-in flow.
@interface GIDSignInInternalOptions : NSObject

/// Whether interaction with user is allowed at all.
@property(nonatomic, readonly) BOOL interactive;

/// Whether the sign-in is a continuation of the previous one.
@property(nonatomic, readonly) BOOL continuation;

/// The extra parameters used in the sign-in URL.
@property(nonatomic, readonly, nullable) NSDictionary *extraParams;

/// Creates the default options.
+ (instancetype)defaultOptions;

/// Creates the options to sign in silently.
+ (instancetype)silentOptions;

/// Creates the options to sign in with extra parameters.
+ (instancetype)optionsWithExtraParams:(NSDictionary *)extraParams;

/// Creates options with the same values as the receiver, except for the "extra parameters", and
/// continuation flag, which are replaced by the arguments passed to this method.
- (instancetype)optionsWithExtraParameters:(NSDictionary *)extraParams
                           forContinuation:(BOOL)continuation;

@end

NS_ASSUME_NONNULL_END