//
//  CCDProjectTest.m
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

#import <XCTest/XCTest.h>

#import "CCDProject.h"

@interface CCDProjectTest : XCTestCase

@end

@implementation CCDProjectTest

CCDProject *project;

- (void)setUp
{
    [super setUp];
    project = [[CCDProject alloc]init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testProjectsShouldReturnListOfObjectsThatBehaveLikeProject
{
    XCTAssertTrue([project respondsToSelector:@selector(name)]);
    XCTAssertTrue([project respondsToSelector:@selector(activity)]);
    XCTAssertTrue([project respondsToSelector:@selector(buildStatus)]);
    XCTAssertTrue([project respondsToSelector:@selector(label)]);
    XCTAssertTrue([project respondsToSelector:@selector(time)]);
    XCTAssertTrue([project respondsToSelector:@selector(url)]);
}

@end
