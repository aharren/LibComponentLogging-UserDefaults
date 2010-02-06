//
//
// LCLUserDefaults.m
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

#import "lcl.h"
#import "LCLUserDefaults.h"


@implementation LCLUserDefaults


//
// Store/restore to/from standard user defaults.
//


// Stores the active log level settings to the standard user defaults.
+ (void)storeLogLevelSettingsToStandardUserDefaults {
    [LCLUserDefaults storeLogLevelSettingsToUserDefaults:[NSUserDefaults standardUserDefaults]];
}

// Stores the active log level settings to the standard user defaults and
// synchronizes the standard user defaults.
+ (void)storeLogLevelSettingsToStandardUserDefaultsAndSynchronize {
    [LCLUserDefaults storeLogLevelSettingsToUserDefaultsAndSynchronize:[NSUserDefaults standardUserDefaults]];
}

// Restores the active log level settings from the standard user defaults.
+ (void)restoreLogLevelSettingsFromStandardUserDefaults {
    [LCLUserDefaults restoreLogLevelSettingsFromUserDefaults:[NSUserDefaults standardUserDefaults]];
}

// Synchronizes the standard user defaults.
+ (void)synchronizeStandardUserDefaults {
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//
// Store/restore to/from special user defaults.
//


// Stores the active log level settings to the given user defaults.
+ (void)storeLogLevelSettingsToUserDefaults:(NSUserDefaults *)defaults {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *prefix = [LCLUserDefaults keyPrefix];
    
    // for all existing log components do ...
    for (_lcl_component_t c = _lcl_component_t_first; c <= _lcl_component_t_last; c++) {
        NSAutoreleasePool *lpool = [[NSAutoreleasePool alloc] init];
        
        // store the log level in the user defaults
        NSString *key = [LCLUserDefaults logLevelKeyForComponent:c
                                                          prefix:prefix];
        [defaults setInteger:(NSInteger)(NSUInteger)_lcl_component_level[c]
                      forKey:key];
        
        [lpool release];
    }
    
    [pool release];
}

// Stores the active log level settings to the given user defaults and
// synchronizes the user defaults.
+ (void)storeLogLevelSettingsToUserDefaultsAndSynchronize:(NSUserDefaults *)defaults {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [LCLUserDefaults storeLogLevelSettingsToUserDefaults:defaults];
    [defaults synchronize];
    
    [pool release];
}

// Restores the active log level settings from the given user defaults.
+ (void)restoreLogLevelSettingsFromUserDefaults:(NSUserDefaults *)defaults {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *prefix = [LCLUserDefaults keyPrefix];
    
    // for all existing log components do ...
    for (_lcl_component_t c = _lcl_component_t_first; c <= _lcl_component_t_last; c++) {
        NSAutoreleasePool *lpool = [[NSAutoreleasePool alloc] init];
        
        // get the log level from the user defaults
        NSString *key = [LCLUserDefaults logLevelKeyForComponent:c
                                                          prefix:prefix];
        NSInteger level = [defaults integerForKey:key];
        
        // unsupported log level, clip to last log level
        if (level > _lcl_level_t_last) {
            level = _lcl_level_t_last;
        }
        
        // configure the component with the log level from the user defaults
        lcl_configure_by_component((_lcl_component_t)c, (_lcl_level_t)(NSUInteger)level);
        
        [lpool release];
    }
    
    [pool release];
}


//
// Methods for creatings prefixes and keys.
//


// Returns this class' key prefix which is used for storing log level settings
// in the user defaults. The prefix is based on this class' bundle identifier
// and has the format "logging:<bundle identifier>:". If the bundle identifier
// doesn't exist, the prefix will be "logging:main:".
+ (NSString *)keyPrefix {
    NSString *bundleIdentifier = [[NSBundle bundleForClass:[LCLUserDefaults class]]
                                  bundleIdentifier];
    if (bundleIdentifier == nil) {
        bundleIdentifier = @"main";
    }
    
    return [NSString stringWithFormat:@"logging:%@:", bundleIdentifier];
}

// Returns a key for the given component and the given prefix and suffix. The
// returned key has the format "<prefix><component name><suffix>".
+ (NSString *)keyForComponent:(_lcl_component_t)component
                       prefix:(NSString *)prefix
                       suffix:(NSString *)suffix {
    return [NSString stringWithFormat:@"%@%@%@",
            prefix,
            [NSString stringWithUTF8String:_lcl_component_name[component]],
            suffix];
}

// Returns a key for the given component and the given prefix and the log level
// suffix.
+ (NSString *)logLevelKeyForComponent:(_lcl_component_t)component
                               prefix:(NSString *)prefix {
    return [LCLUserDefaults
            keyForComponent:component
            prefix:prefix
            suffix:@":level"];
}

@end

