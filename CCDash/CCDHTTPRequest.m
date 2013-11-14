//
//  CCDHttpRequest.m
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

#import "CCDHTTPRequest.h"

@implementation CCDHTTPRequest

@synthesize error = _error;
@synthesize response = _response;

- (id)initWithURL:(NSURL *)requestURL
{
    self = [super init];
    if (self) {
        _requestURL = requestURL;
    }
    return self;
}

-(void)send
{
    NSData *responseData;
    if ((responseData = [self receiveResponse]) != nil) {
        [self storeResponse:responseData];
    }
}

- (NSData *)receiveResponse
{
    NSMutableURLRequest *request = [self createGETRequest];
    NSError *sendError = [[NSError alloc] init];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&sendError];
    if ([sendError code] != 0) {
        [self handleHTTPError:sendError];
        return nil;
    }
    return responseData;
}

- (NSMutableURLRequest *)createGETRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:_requestURL];
    [request setHTTPMethod:@"GET"];
    return request;
}

- (void)storeResponse:(NSData *)responseData
{
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *receiveError = [[NSError alloc] init];
    _response = [[NSXMLDocument alloc] initWithXMLString:result options:NSXMLDocumentTidyXML error:&receiveError];
    if ([receiveError code] != 0) {
        [self handleHTTPError:receiveError];
    }
}

- (void)handleHTTPError:(NSError *)error
{
    NSLog(@"%@ Error %@ (%@)", [error domain], [error localizedDescription], [_requestURL absoluteString]);
    _error = YES;
}

@end
