//
//
// UserDefaultsTestsLogLevelSettingsTests.m
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
#import <SenTestingKit/SenTestingKit.h>


@interface UserDefaultsTestsLogLevelSettingsTests : SenTestCase {
    
}

@end


@implementation UserDefaultsTestsLogLevelSettingsTests

- (void)setUp {
}

- (void)testLogLevelSettingsStoreAndRestoreWithStandardUserDefaults {
    // reset the log levels
    lcl_configure_by_name("*", lcl_vOff);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)0, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)0, nil);
    
    // set some log levels
    lcl_configure_by_component(lcl_cComponent1, lcl_vInfo);
    lcl_configure_by_component(lcl_cComponent2, lcl_vError);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vInfo, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vError, nil);
    
    // store the log level settings to the standard user defaults
    [LCLUserDefaults storeLogLevelSettingsToStandardUserDefaults];
    
    // reset the log levels
    lcl_configure_by_name("*", lcl_vOff);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)0, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)0, nil);
    
    // restore the log level settings from the standard user defaults
    [LCLUserDefaults restoreLogLevelSettingsFromStandardUserDefaults];
    
    // check log levels
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vInfo, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vError, nil);
}

- (void)testLogLevelSettingsStoreAndRestoreWithStandardUserDefaultsAndSynchronize {
    // reset the log levels
    lcl_configure_by_name("*", lcl_vOff);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)0, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)0, nil);
    
    // set some log levels
    lcl_configure_by_component(lcl_cComponent1, lcl_vTrace);
    lcl_configure_by_component(lcl_cComponent2, lcl_vDebug);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vTrace, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vDebug, nil);
    
    // store the log level settings to the standard user defaults and synchronize
    [LCLUserDefaults storeLogLevelSettingsToStandardUserDefaultsAndSynchronize];
    
    // reset the standard user defaults
    [NSUserDefaults resetStandardUserDefaults];
    
    // reset the log levels
    lcl_configure_by_name("*", lcl_vOff);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)0, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)0, nil);
    
    // restore the log level settings from the standard user defaults
    [LCLUserDefaults restoreLogLevelSettingsFromStandardUserDefaults];
    
    // check log levels
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vTrace, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vDebug, nil);
}

@end

