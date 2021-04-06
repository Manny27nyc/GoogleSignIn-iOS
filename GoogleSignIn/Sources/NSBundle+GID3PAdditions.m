// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GoogleSignIn/Sources/NSBundle+GID3PAdditions.h"

#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation NSBundle (GID3PAdditions)

+ (nullable NSBundle *)gid_frameworkBundle {
  NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
  NSString* frameworkBundlePath = [mainBundlePath
      stringByAppendingPathComponent:@"GoogleSignIn.bundle"];
  return [NSBundle bundleWithPath:frameworkBundlePath];
}

+ (void)gid_registerFonts {
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    NSArray* allFontNames = @[ @"Roboto-Bold" ];
    NSBundle* bundle = [self gid_frameworkBundle];
    for (NSString *fontName in allFontNames) {
      // Check to see if the font is already here, and skip registration if so.
      if ([UIFont fontWithName:fontName size:[UIFont systemFontSize]]) {  // size doesn't matter
        continue;
      }

      // Load the font data file from the bundle.
      NSString *path = [bundle pathForResource:fontName ofType:@"ttf"];
      CGDataProviderRef provider = CGDataProviderCreateWithFilename([path UTF8String]);
      CFErrorRef error;
      CGFontRef newFont = CGFontCreateWithDataProvider(provider);
      if (!newFont || !CTFontManagerRegisterGraphicsFont(newFont, &error)) {
#ifdef DEBUG
        NSLog(@"Unable to load font: %@", fontName);
#endif
      }
      CGFontRelease(newFont);
      CGDataProviderRelease(provider);
    }
  });
}

@end

NS_ASSUME_NONNULL_END