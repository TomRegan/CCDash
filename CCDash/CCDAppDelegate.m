//
//  CCDAppDelegate.m
//  CCDash
//
//  Copyright 2013 Tom Regan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "CCDAppDelegate.h"
#import "CCDHTTPRequest.h"

@implementation CCDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL *serverURL = [NSURL URLWithString:@"https://raw.github.com/TomRegan/libccxml/master/test/resources/travis/cc.xml"];
    CCDHTTPRequest *request = [[CCDHTTPRequest alloc ]initWithURL:serverURL];
    [request send];
    if (![request error]) {
        NSLog(@"Response: %@", [request response]);
    } else {
        NSLog(@"There was an error. Please enhance your calm and try again.");
    }
}

@end
