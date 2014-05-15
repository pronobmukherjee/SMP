//
//  SMPAppDelegate.h
//  MyStartedApplication
//
//  Created by Pronob Mukherjee on 25/03/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPLogonHandler.h"
#import "MAFUIStyleParser.h"
#import "SMPViewController.h"

@class SMPViewController;

@interface SMPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SMPLogonHandler *logonHandler;
@property (strong, nonatomic) SMPViewController *viewController;
    
@end
