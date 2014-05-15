//
//  SMPLogonHandler.m
//  MyStartedApplication
//
//  Created by Pronob Mukherjee on 25/03/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import "SMPLogonHandler.h"

@implementation SMPLogonHandler

-(id) init{
    self = [super init];
    if(self){
        self.logonUIViewManager = [[MAFLogonUIViewManager alloc] init];
        // set up the logon delegate
        [self.logonManager setLogonDelegate:self];
        // save reference to LogonManager for code readability
        self.logonManager = self.logonUIViewManager.logonManager;
        #warning You must set your own application id. The application id can be specified in the info.plist file.
        NSLog(@"SMPLogonHandler Called");
    }
    return self;
}
    
#pragma mark - MAFLogonNGDelegate impolementation
    
-(void) logonFinishedWithError:(NSError*)anError {
    NSLog(@"logonFinishedWithError:%@", anError);
    NSLog(@"LOGON");
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

@end
