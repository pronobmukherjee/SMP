//
//  LeaveBalanceViewController.m
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 15/05/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import "LeaveBalanceViewController.h"
#import "ODataEntry.h"
#import "ODataProperty.h"

@interface LeaveBalanceViewController ()

@end

@implementation LeaveBalanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"self.empId=%@",self.empId);
    NSString *query = [NSString stringWithFormat:@"?$filter=EMP_ID eq '%@'",self.empId];
    query = [query stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self.controller setDelegate:self];
    self.controller.entityName = @"EMPLOYEELEAVEBALANCE";
    [self.controller requestData:query];
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
    NSLog(@"blalance self.results=%@",[self.results description]);
    ODataEntry *entry = [self.results objectAtIndex:0];
    NSMutableDictionary *fields = [entry getFields];
    ODataPropertyValueObject *sl = [fields objectForKey:@"SL"];
    ODataPropertyValueObject *cl = [fields objectForKey:@"CL"];
    ODataPropertyValueObject *pl = [fields objectForKey:@"PL"];
    ODataPropertyValueObject *asl = [fields objectForKey:@"ASL"];
    self.SL.text = [sl getValue];
    self.CL.text = [cl getValue];
    self.PL.text = [pl getValue];
    self.ASL.text = [asl getValue];
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
