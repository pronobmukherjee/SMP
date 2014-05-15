//
//  EmployeeDetailViewController.h
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 15/05/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPDelegate.h"
#import "SMPController.h"
#import "LeaveBalanceViewController.h"
#import "LeavesTakenViewController.h"
#import "SMPAppDelegate.h"

@interface EmployeeDetailViewController : UIViewController<smpDelegate>

// Our buttons and result table
@property (weak, nonatomic) IBOutlet UIButton *leaveBalanceButton;
@property (weak, nonatomic) IBOutlet UIButton *leavesTakenButton;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *designation;
@property (weak, nonatomic) IBOutlet UILabel *reportingTo;
@property (weak, nonatomic) IBOutlet UILabel *doj;

// Our SMP Controller instance.
@property (strong, nonatomic) SMPController *controller;

// The array in which we will store our results.
@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSString *empId;


// Our actions on the buttons
- (IBAction)leavesBalance:(id)sender;
- (IBAction)leavesTaken:(id)sender;

@end
