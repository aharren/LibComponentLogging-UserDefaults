

# LibComponentLogging-UserDefaults

[http://0xc0.de/LibComponentLogging](http://0xc0.de/LibComponentLogging)    
[http://github.com/aharren/LibComponentLogging-UserDefaults](http://github.com/aharren/LibComponentLogging-UserDefaults)


## Overview

LibComponentLogging-UserDefaults is a LibComponentLogging Core extension which
stores/restores settings to/from the user defaults.

Currently, the LCLUserDefaults class can only store/restore active log level
settings.


## Usage

The following code shows a simple usage pattern for LCLUserDefaults in your
application's main.m file:

    #include "lcl.h"
    #include "LCLUserDefaults.h"
    
    int main(int argc, char *argv[]) {
        // restore the log level settings from the standard user defaults
        [LCLUserDefaults restoreLogLevelSettingsFromStandardUserDefaults];
        
        // start your application
        ...
    }

LCLUserDefaults uses the following format for storing log level settings
in your application's domain:

    "logging:<bundle identifier>:<log component name>:level" = <integer>

Examples:

    "logging:com.yourcompany.YourApplication:Application/Component 1:level" = 5
    "logging:com.yourcompany.YourApplication:Application/Component 2:level" = 3

You can change the log level settings from the command line by using the
'defaults' command, e.g.

    defaults write <application> "logging:com.yourcompany.YourApplication:Application/Component 1:level" -int 2


## Repository Branches

The Git repository contains the following branches:

* [master](http://github.com/aharren/LibComponentLogging-UserDefaults/tree/master):
  The *master* branch contains stable builds of the code which are tagged with
  version numbers.

* [devel](http://github.com/aharren/LibComponentLogging-UserDefaults/tree/devel):
  The *devel* branch is the development branch for the code which contains an
  Xcode project and unit tests. The code in this branch is not stable.


## Related Repositories

The following Git repositories are related to this repository:

* [http://github.com/aharren/LibComponentLogging-Core](http://github.com/aharren/LibComponentLogging-Core):
  Core files of LibComponentLogging.


## Copyright and License

Copyright (c) 2009-2010 Arne Harren <ah@0xc0.de>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

