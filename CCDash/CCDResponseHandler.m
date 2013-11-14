//
//  CCDResponseHandler.m
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

#import "CCDResponseHandler.h"
#import "CCDProject.h"

@implementation CCDResponseHandler

+(NSArray*)projectsFromXML:(NSXMLDocument *)aDocument
{
    NSMutableArray *projects = [[NSMutableArray alloc]init];
    // FIXME we need to handle the possibility of case inconsistancies
    for (NSXMLElement *element in [[aDocument rootElement] elementsForName:@"Project"]) {
        CCDProject *project = [[CCDProject alloc]init];
        [project setName:[[element attributeForName:@"name"] stringValue]];
        [project setActivity:[[element attributeForName:@"activity"] stringValue]];
        [project setBuildStatus:[[element attributeForName:@"lastBuildStatus"] stringValue]];
        [project setLabel:[[element attributeForName:@"lastBuildLabel"] stringValue]];
        [project setTime:[[element attributeForName:@"lastBuildTime"] stringValue]];
        [project setUrl:[[element attributeForName:@"webUrl"] stringValue]];
        [projects addObject:project];
    }
    return [NSArray arrayWithArray:projects];
}

@end
