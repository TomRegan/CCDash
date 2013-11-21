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
#import <OCMock/OCMock.h>

#import "CCDProject.h"

@interface CCDProjectTest : XCTestCase

@end

@implementation CCDProjectTest

CCDProject *project;

- (void)setUp
{
    [super setUp];
    project = [[CCDProject alloc] init];
}

- (void)tearDown
{
    [super tearDown];
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

- (void)testProjectFromXMLElementShouldPopulateProperties
{
    CCDProject *project = [[CCDProject alloc] initFromXMLElement:[self mockXMLElement]];
    XCTAssertEqualObjects(@"Onomatopoeia", [project name]);
    XCTAssertEqualObjects(@"Fondling", [project activity]);
    XCTAssertEqualObjects(@"Regal", [project buildStatus]);
    XCTAssertEqualObjects(@"Price", [project label]);
    XCTAssertEqualObjects(@"Cowboy", [project time]);
    XCTAssertEqualObjects(@"Gray", [project url]);
}

- (id)mockXMLElement
{
    id mockXMLElement = [OCMockObject mockForClass:[NSXMLElement class]];
    [self stubElement:mockXMLElement forAttribute:@"name" thatReturns:@"Onomatopoeia"];
    [self stubElement:mockXMLElement forAttribute:@"activity" thatReturns:@"Fondling"];
    [self stubElement:mockXMLElement forAttribute:@"lastBuildStatus" thatReturns:@"Regal"];
    [self stubElement:mockXMLElement forAttribute:@"lastBuildLabel" thatReturns:@"Price"];
    [self stubElement:mockXMLElement forAttribute:@"lastBuildTime" thatReturns:@"Cowboy"];
    [self stubElement:mockXMLElement forAttribute:@"webUrl" thatReturns:@"Gray"];
    return mockXMLElement;
}

- (void)stubElement:(id)anElement forAttribute:(NSString*)anAttribute thatReturns:(NSString*)aString
{
    id mockXMLNode = [OCMockObject mockForClass:[NSXMLNode class]];
    [[[mockXMLNode stub] andReturn:aString] stringValue];
    [[[anElement stub] andReturn:mockXMLNode] attributeForName:anAttribute];
}

@end
