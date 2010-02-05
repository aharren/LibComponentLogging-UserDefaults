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

- (void)clearStandardUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"logging:com.yourcompany.YourApplication:Application/Component 1:level"];
    [defaults removeObjectForKey:@"logging:com.yourcompany.YourApplication:Application/Component 2:level"];
    [defaults synchronize];
    [NSUserDefaults resetStandardUserDefaults];
}

- (void)setUp {
    [self clearStandardUserDefaults];
    
    // reset the log levels
    lcl_configure_by_name("*", lcl_vOff);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)0, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)0, nil);
}

- (void)tearDown {
    [self clearStandardUserDefaults];
}

- (void)testLogLevelSettingsStoreAndRestoreWithStandardUserDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // set some log levels
    lcl_configure_by_component(lcl_cComponent1, lcl_vInfo);
    lcl_configure_by_component(lcl_cComponent2, lcl_vError);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vInfo, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vError, nil);
    
    // check the standard user defaults
    STAssertNil([defaults objectForKey:@"logging:com.yourcompany.YourApplication:Application/Component 1:level"], nil);
    STAssertNil([defaults objectForKey:@"logging:com.yourcompany.YourApplication:Application/Component 2:level"], nil);
    
    // store the log level settings to the standard user defaults
    [LCLUserDefaults storeLogLevelSettingsToStandardUserDefaults];
    
    // check the standard user defaults
    STAssertEquals([defaults integerForKey:@"logging:com.yourcompany.YourApplication:Application/Component 1:level"], (NSInteger)lcl_vInfo, nil);
    STAssertEquals([defaults integerForKey:@"logging:com.yourcompany.YourApplication:Application/Component 2:level"], (NSInteger)lcl_vError, nil);
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // set some log levels
    lcl_configure_by_component(lcl_cComponent1, lcl_vTrace);
    lcl_configure_by_component(lcl_cComponent2, lcl_vDebug);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vTrace, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vDebug, nil);
    
    // check the standard user defaults
    STAssertNil([defaults objectForKey:@"logging:com.yourcompany.YourApplication:Application/Component 1:level"], nil);
    STAssertNil([defaults objectForKey:@"logging:com.yourcompany.YourApplication:Application/Component 2:level"], nil);
    
    // store the log level settings to the standard user defaults and synchronize
    [LCLUserDefaults storeLogLevelSettingsToStandardUserDefaultsAndSynchronize];
    
    // check the standard user defaults
    STAssertEquals([defaults integerForKey:@"logging:com.yourcompany.YourApplication:Application/Component 1:level"], (NSInteger)lcl_vTrace, nil);
    STAssertEquals([defaults integerForKey:@"logging:com.yourcompany.YourApplication:Application/Component 2:level"], (NSInteger)lcl_vDebug, nil);
    
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

- (void)testLogLevelSettingsDefaultsWriteAndRestoreWithStandardUserDefaults {
    // change log levels via shell command
    NSString *command1 = [NSString stringWithFormat:@"defaults write \"%@\" \"%@\" -int %d",
                          [[[NSBundle mainBundle] executablePath] lastPathComponent],
                          @"logging:com.yourcompany.YourApplication:Application/Component 1:level",
                          2];
    system([command1 cStringUsingEncoding:NSUTF8StringEncoding]);
    NSString *command2 = [NSString stringWithFormat:@"defaults write \"%@\" \"%@\" -int %d",
                          [[[NSBundle mainBundle] executablePath] lastPathComponent],
                          @"logging:com.yourcompany.YourApplication:Application/Component 2:level",
                          1];
    system([command2 cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // restore the log level settings from the standard user defaults
    [LCLUserDefaults restoreLogLevelSettingsFromStandardUserDefaults];
    
    // check log levels
    STAssertEquals((int)_lcl_component_level[lcl_cComponent1], (int)lcl_vError, nil);
    STAssertEquals((int)_lcl_component_level[lcl_cComponent2], (int)lcl_vCritical, nil);
}

@end

