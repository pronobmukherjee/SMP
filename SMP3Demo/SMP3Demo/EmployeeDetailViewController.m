//
//  EmployeeDetailViewController.m
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 15/05/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import "EmployeeDetailViewController.h"
#import "ODataEntry.h"
#import "ODataProperty.h"

@interface EmployeeDetailViewController ()

@end

@implementation EmployeeDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"self.empId=%@",self.empId);
    NSString *query = [NSString stringWithFormat:@"(%@)",self.empId];
    [self.controller setDelegate:self];
    self.controller.entityName = @"EMPLOYEE";
    [self.controller requestData:query];
}

// Our actions on the buttons
- (IBAction)leavesBalance:(id)sender
{
    LeaveBalanceViewController *controller = [[LeaveBalanceViewController alloc] initWithNibName:@"LeaveBalanceViewController" bundle:Nil];
    controller.empId = self.empId;
    controller.controller = self.controller;
    SMPAppDelegate *delegate = (SMPAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.mainController.navigationController pushViewController:controller animated:YES];
}

- (IBAction)leavesTaken:(id)sender
{
    LeavesTakenViewController *controller = [[LeavesTakenViewController alloc] initWithNibName:@"LeavesTakenViewController" bundle:Nil];
    controller.empId = self.empId;
    controller.controller = self.controller;
    SMPAppDelegate *delegate = (SMPAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.mainController.navigationController pushViewController:controller animated:YES];
}

#pragma mark - SMP delegate methods

// Callback for when the user-registration was OK.
- (void)userRegistrationSuccessful{
}

// Callbcak for when the user-registration failed.
- (void)userRegistrationFailed:(NSString *)message{
}

// Callback for when we have received the data.
- (void)dataRetrievalComplete:(NSMutableArray *)results{
    // Update table here.
    self.results = results;
    NSLog(@"details self.results=%@",[self.results description]);
    ODataEntry *entry = [self.results objectAtIndex:0];
    NSMutableDictionary *fields = [entry getFields];
    ODataPropertyValueObject *firstname = [fields objectForKey:@"FIRSTNAME"];
    ODataPropertyValueObject *lastname = [fields objectForKey:@"LASTNAME"];
    ODataPropertyValueObject *desig = [fields objectForKey:@"DESIGNATION"];
    ODataPropertyValueObject *reportingTo = [fields objectForKey:@"REPORTINGTO"];
    ODataPropertyValueObject *doj = [fields objectForKey:@"DOJ"];
    self.name.text = [NSString stringWithFormat:@"%@ %@",[firstname getValue],[lastname getValue]];
    self.designation.text = [desig getValue];
    self.reportingTo.text = [reportingTo getValue];
    self.doj.text = [doj getValue];
}

// Callback for when the data retrieval failed.
- (void)dataRetrievalFailed{
    [self displayError:@"Unable to retrieve details data"];
}

- (void)displayError:(NSString *)error{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"ERROR"
                              message:error
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
