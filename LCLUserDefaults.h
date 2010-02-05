//
//
// LCLUserDefaults.h
//
//
// Copyright (c) 2009-2010 Arne Harren <ah@0xc0.de>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#define _LCLUSERDEFAULTS_VERSION_MAJOR  1
#define _LCLUSERDEFAULTS_VERSION_MINOR  0
#define _LCLUSERDEFAULTS_VERSION_BUILD  0
#define _LCLUSERDEFAULTS_VERSION_SUFFIX "-devel"

//
// LCLUserDefaults
//
// LCLUserDefaults is a LibComponentLogging Core extension which stores/restores
// settings to/from the user defaults.
//
// Currently, LCLUserDefaults can only store/restore active log levels settings.
//


#import <Foundation/Foundation.h>


@interface LCLUserDefaults : NSObject {
    
}


//
// Store/restore to/from standard user defaults.
//


// Stores the active log level settings to the standard user defaults.
+ (void)storeLogLevelSettingsToStandardUserDefaults;

// Stores the active log level settings to the standard user defaults and
// synchronizes the standard user defaults.
+ (void)storeLogLevelSettingsToStandardUserDefaultsAndSynchronize;

// Restores the active log level settings from the standard user defaults.
+ (void)restoreLogLevelSettingsFromStandardUserDefaults;

// Synchronizes the standard user defaults.
+ (void)synchronizeStandardUserDefaults;


//
// Store/restore to/from special user defaults.
//


// Stores the active log level settings to the given user defaults.
+ (void)storeLogLevelSettingsToUserDefaults:(NSUserDefaults *)defaults;

// Stores the active log level settings to the given user defaults and
// synchronizes the user defaults.
+ (void)storeLogLevelSettingsToUserDefaultsAndSynchronize:(NSUserDefaults *)defaults;

// Restores the active log level settings from the given user defaults.
+ (void)restoreLogLevelSettingsFromUserDefaults:(NSUserDefaults *)defaults;


//
// Methods for creatings prefixes and keys.
//


// Returns this class' key prefix which is used for storing log level settings
// in the user defaults. The prefix is based on this class' bundle identifier
// and has the format "logging:<bundle identifier>:". If the bundle identifier
// doesn't exist, the prefix will be "logging:main:".
+ (NSString *)keyPrefix;

// Returns a key for the given component and the given prefix and suffix. The
// returned key has the format "<prefix><component name><suffix>".
+ (NSString *)keyForComponent:(_lcl_component_t)component
                       prefix:(NSString *)prefix
                       suffix:(NSString *)suffix;

// Returns a key for the given component and the given prefix and the log level
// suffix.
+ (NSString *)logLevelKeyForComponent:(_lcl_component_t)component
                               prefix:(NSString *)prefix;

@end

