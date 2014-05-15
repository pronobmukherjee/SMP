//
//  SMPAppDelegate.h
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 27/03/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class MainViewController;

@interface SMPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic)MainViewController *mainController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
