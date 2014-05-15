//
//  SMPLogonHandler.h
//  MyStartedApplication
//
//  Created by Pronob Mukherjee on 25/03/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAFLogonNGPublicAPI.h"
#import "MAFLogonUIViewManager.h"
#import "MAFLogonNGDelegate.h"
#import "SMPUserManager.h"

@interface SMPLogonHandler : NSObject <MAFLogonNGDelegate>

@property (strong, nonatomic) MAFLogonUIViewManager *logonUIViewManager;
@property (strong, nonatomic) NSObject<MAFLogonNGPublicAPI> *logonManager;
@property (strong, nonatomic) NSString *communicatorId;
@property (strong, nonatomic) NSString *appEndpoint;

@end
