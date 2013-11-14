//
//  CCDResponseHandlerTest.m
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

#import "CCDResponseHandler.h"
#import "CCDProject.h"

@interface CCDResponseHandlerTest : XCTestCase

@end

@implementation CCDResponseHandlerTest

NSXMLDocument *document;
NSXMLDocument *multiProjectDocument;

- (void)setUp
{
    [super setUp];
    id mockReceiveError = [OCMockObject mockForClass:[NSError class]];
    NSString *responseString = @"<Projects><Project name=\"kriswallsmith/assetic\" activity=\"Sleeping\" lastBuildStatus=\"Success\" lastBuildLabel=\"558\" lastBuildTime=\"2013-07-17T09:12:24.000+0000\" webUrl=\"https://travis-ci.org/kriswallsmith/assetic\" /></Projects>";
    document = [[NSXMLDocument alloc] initWithXMLString:responseString options:NSXMLDocumentTidyXML error:&mockReceiveError];

    
    NSString *multiProjectResponseString = @"<Projects><Project name=\"kriswallsmith/assetic\" activity=\"Sleeping\" lastBuildStatus=\"Success\" lastBuildLabel=\"558\" lastBuildTime=\"2013-07-17T09:12:24.000+0000\" webUrl=\"https://travis-ci.org/kriswallsmith/assetic\" /><Project name=\"AmazingProject\" activity=\"Sleeping\" lastBuildStatus=\"Success\" lastBuildLabel=\"9999\" lastBuildTime=\"2013-07-17T09:12:24.000+0000\" webUrl=\"https://go.thoughtworks.com/AmazingProject\" /></Projects>";
    multiProjectDocument = [[NSXMLDocument alloc] initWithXMLString:multiProjectResponseString options:NSXMLDocumentTidyXML error:&mockReceiveError];

}

- (void)tearDown
{
    [super tearDown];
}

- (void)testProjectsShouldReturnListContainingOneProject
{
    XCTAssertEqual((NSUInteger)1, [[CCDResponseHandler projectsFromXML:document]count]);
}

-(void)testProjectsShouldReturnCorrectlyConfiguredProjectObject
{
    id project = [CCDResponseHandler projectsFromXML:document][0];
    XCTAssertEqualObjects(@"kriswallsmith/assetic", [project name]);
    XCTAssertEqualObjects(@"Sleeping", [project activity]);
    XCTAssertEqualObjects(@"Success", [project buildStatus]);
    XCTAssertEqualObjects(@"558", [project label]);
    XCTAssertEqualObjects(@"2013-07-17T09:12:24.000+0000", [project time]);
    XCTAssertEqualObjects(@"https://travis-ci.org/kriswallsmith/assetic", [project url]);
}

-(void)testProjectsShouldReturnCorrectlyConfiguredProjectObjects
{
    id project = [CCDResponseHandler projectsFromXML:multiProjectDocument][1];
    XCTAssertEqualObjects(@"AmazingProject", [project name]);
    XCTAssertEqualObjects(@"9999", [project label]);
    XCTAssertEqualObjects(@"https://go.thoughtworks.com/AmazingProject", [project url]);
    
}

@end
