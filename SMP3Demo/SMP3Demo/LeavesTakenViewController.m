//
//  LeavesTakenViewController.m
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 15/05/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import "LeavesTakenViewController.h"
#import "ODataEntry.h"
#import "ODataProperty.h"
#import "CustomCell.h"

@interface LeavesTakenViewController ()

@end

@implementation LeavesTakenViewController

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
    self.controller.entityName = @"EMPLOYEELEAVES";
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
    NSLog(@"leaves taken self.results=%@",[self.results description]);
    [self.leavesTable reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return the number of records we have in the results array.
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get a table view cell to work with.
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:Nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    // Get the entry we currently want to display.
    ODataEntry *entry = [self.results objectAtIndex:[indexPath row]];
    NSMutableDictionary *fields = [entry getFields];
    
    // Retrieve the value for employee first name
    ODataPropertyValueObject *leaveType = [fields objectForKey:@"LEAVETYPE"];
    // Retrieve the value for employee last name
    ODataPropertyValueObject *duration = [fields objectForKey:@"LEAVEDURATION"];
    ODataPropertyValueObject *applied = [fields objectForKey:@"APPLIEDON"];
    ODataPropertyValueObject *approved = [fields objectForKey:@"APPROVEDON"];
    ODataPropertyValueObject *reason = [fields objectForKey:@"REASON"];
    ODataPropertyValueObject *status = [fields objectForKey:@"STATUS"];
    
    // Set the value on the cell.
    [cell.leaveType setText:[leaveType getValue]];
    [cell.leaveDuration setText:[duration getValue]];
    [cell.appliedOn setText:[applied getValue]];
    [cell.approvedOn setText:[approved getValue]];
    [cell.reason setText:[reason getValue]];
    [cell.status setText:[status getValue]];
    // Return the cell complete.
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
