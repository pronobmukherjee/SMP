//
//  SMPViewController.m
//  MyStartedApplication
//
//  Created by Pronob Mukherjee on 25/03/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import "SMPViewController.h"

@interface SMPViewController ()

@end

@implementation SMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    SMPAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.logonUIViewManager = [[MAFLogonUIViewManager alloc] init];
//    self.logonHandler = [[SMPLogonHandler alloc] init];
    self.logonUIViewManager.parentViewController = self;
    self.logonManager = self.logonUIViewManager.logonManager;
    [self.logonManager setLogonDelegate:self];
    NSLog(@"SMPViewController CAlled");
}

#pragma mark - MAFLogonNGDelegate impolementation
    
-(void) logonFinishedWithError:(NSError*)anError {
    NSLog(@"logonFinishedWithError:%@", anError);
    NSLog(@"LOGON");
    NSError* localError = nil;
    self.registrationData = [self.logonManager registrationDataWithError:&localError];
    if (localError) {
        //handle error
    } else {
        //access registration data, like:
        self.communicatorId = self.registrationData.communicatorId;
        self.appEndpoint = self.registrationData.applicationEndpointURL;
        NSLog(@"data=%@",self.registrationData);
        NSLog(@"self.communicatorId=%@",self.communicatorId);
        NSLog(@"self.appEndpoint=%@",self.appEndpoint);
        NSLog(@"Conn Id=%@",self.registrationData.applicationConnectionId);
        self.appEndpointUrl = [[self.registrationData.connectionData valueForKey:keyMAFLogonConnectionDataApplicationSettings] valueForKey:keyApplicationSettings_ProxyApplicationEndpoint];
        
        NSLog(@"self.appEndpointUrl=%@",self.appEndpointUrl);
        
        NSString* fullEndpoint = self.appEndpoint;
        if([self.communicatorId isEqualToString:idMAFLogonCommunicator_GatewayOnly]){
            NSString* serviceDocumentFormat = @"";
            if([fullEndpoint hasSuffix:@"/"]){
                serviceDocumentFormat = @"sap/opu/odata/GBHCM/LEAVEREQUEST/";
            }
            else{
                serviceDocumentFormat = @"/sap/opu/odata/GBHCM/LEAVEREQUEST/";
            }
            
            fullEndpoint = [fullEndpoint stringByAppendingString:serviceDocumentFormat];
            self.appEndpoint = fullEndpoint;
        }
        NSLog(@"self.appEndpoint=%@",self.appEndpoint);
        [RequestBuilder setRequestType:HTTPRequestType];
        id<Requesting> request = [RequestBuilder requestWithURL:[[NSURL alloc] initWithString:self.appEndpoint]];
        [request setUsername:self.registrationData.backendUserName];
        [request setPassword:self.registrationData.backendPassword];
        
        [request setRequestMethod:@"GET"];
        if([self.registrationData.communicatorId isEqualToString:idMAFLogonCommunicator_SMPHTTPREST]){
            [request addRequestHeader:@"X-SUP-APPCID" value:self.registrationData.applicationConnectionId];
            [request addRequestHeader:@"X-SMP-APPCID" value:self.registrationData.applicationConnectionId];
        }
        // This class is the delegate callback for any notifications (success and failure)
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(handleReqSuccess:)];
        [request setDidFailSelector:@selector(handleReqFailed:)];
        
        // Each request can be tagged with a number - useful later.
        request.requestTag = 1; // Useful for a change request.
        
        // Start our request.
        [request startAsynchronous];
    }
}

#pragma mark - request callbacks
// Generic failure method once a request fails.
- (void) handleReqFailed:(id)sender{
    
    NSLog(@"Request Failed");
    
    // Tell any listening delegate that there has been a failure.
    if (self.delegate && [self.delegate respondsToSelector:@selector(userRegistrationSuccessful)]) {
        [self.delegate dataRetrievalFailed];
    }
}

// Generic success method once a request is complete.
- (void) handleReqSuccess:(Request *)request{
    
    // Based on which request it is (each request was tagged)
    // Call the correct response parser.
    switch ([request requestTag]) {
        case 1: // This is the service Document
            [self parseServiceDocumentRequest:request];
            break;
        case 2: // This is the metadata.
            [self parseMetadataRequest:request];
            break;
        case 3: // this is the actual data.
            [self parseDataRequest:request];
            break;
        default:
            break;
    }
    NSLog(@"Request number %i Successful", [request requestTag]);
}

/*
 * returns an Request instance for the url
 */
-(id<Requesting>) requestWithURL:(NSURL *) url withMethodType:(NSString *)methodType{
    id<Requesting> request = nil;
    
    //getting the request object from SMP OData client library.
    request = [RequestBuilder requestWithURL:url];
    
    [request setUsername:self.registrationData.backendUserName];
    [request setPassword:self.registrationData.backendPassword];
    
    [request setRequestMethod:methodType];
    if([self.registrationData.communicatorId isEqualToString:idMAFLogonCommunicator_SMPHTTPREST]){
        [request addRequestHeader:@"X-SUP-APPCID" value:self.registrationData.applicationConnectionId];
        [request addRequestHeader:@"X-SMP-APPCID" value:self.registrationData.applicationConnectionId];
    }
    return request;
}

-(void) lockSecureStoreFinishedWithError:(NSError*)anError {
    NSLog(@"lockSecureStoreFinishedWithError:%@", anError);
}
-(void) updateApplicationSettingsFinishedWithError:(NSError*)anError { NSLog(@"updateApplicationSettingsFinishedWithError:%@", anError);
}
-(void) uploadTraceFinishedWithError:(NSError *)anError {
    NSLog(@"uploadTraceFinishedWithError:%@", anError);
}
-(void) changeBackendPasswordFinishedWithError:(NSError*)anError {
    NSLog(@"Password change with error:%@", anError);
}
-(void) deleteUserFinishedWithError:(NSError*)anError {
    NSLog(@"deleteUserFinishedWithError:%@", anError);
}
-(void) changeSecureStorePasswordFinishedWithError:(NSError*)anError {
    NSLog(@"changeSecureStorePasswordFinishedWithError:%@", anError);
}
-(void) registrationInfoFinishedWithError:(NSError*)anError {
    NSLog(@"registrationInfoFinishedWithError:%@", anError);
}
-(void) startDemoMode {
    NSLog(@"startDemoMode");
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
