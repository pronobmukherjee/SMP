//
//  SMPViewController.h
//  MyStartedApplication
//
//  Created by Pronob Mukherjee on 25/03/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPLogonHandler.h"
#import "SMPAppDelegate.h"
#import "MAFLogonSMPConstants.h"
#import "MAFLogonCommunicatorConstants.h"
#import "Requesting.h"
#import "RequestDelegate.h"
#import "RequestBuilder.h"
#import "Request.h"
#import "SMPClientConnection.h"
#import "SMPUserManager.h"

@interface SMPViewController : UIViewController<MAFLogonNGDelegate>

// We have to have a delegate to callback to.
@property (strong, nonatomic) id<smpAppDelegate> delegate;

// An object representing our connection to the SMP server.
@property (strong, nonatomic) SMPClientConnection *clientConn;

@property (nonatomic, retain) SMPLogonHandler *logonHandler;
    @property (strong, nonatomic) MAFLogonUIViewManager *logonUIViewManager;
    @property (strong, nonatomic) NSObject<MAFLogonNGPublicAPI> *logonManager;
    @property (strong, nonatomic) NSString *communicatorId;
    @property (strong, nonatomic) NSString *appEndpoint;
@property (strong, nonatomic) NSString *appConnectionId;
@property (strong, nonatomic) NSString *appEndpointUrl;
@property (strong, nonatomic) MAFLogonRegistrationData* registrationData;

-(id<Requesting>) requestWithURL:(NSURL *) url withMethodType:(NSString *)methodType;

@end
