//
//  MainViewController.m
//  SMP3-101
//
//  Created by Brenton O'Callaghan on 30/01/2014.
//  Copyright (c) 2014 Bluefin Solutions. All rights reserved.
//

#import "MainViewController.h"
#import "ODataEntry.h"
#import "ODataProperty.h"

@interface MainViewController ()

// Our SMP Controller instance.
@property (strong, nonatomic) SMPController *controller;

// The array in which we will store our results.
@property (strong, nonatomic) NSMutableArray *results;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.controller = [[SMPController alloc] init];
        [self.controller setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [self.downloadDataButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UIButtonTypeDetailDisclosure;
    // Get the entry we currently want to display.
    ODataEntry *entry = [self.results objectAtIndex:[indexPath row]];
    NSMutableDictionary *fields = [entry getFields];
    
    // Retrieve the value for employee first name
    ODataPropertyValueObject *firstNameObject = [fields objectForKey:@"FIRSTNAME"];
    // Retrieve the value for employee last name
    ODataPropertyValueObject *lastNameObject = [fields objectForKey:@"LASTNAME"];
    
    // Set the value on the cell.
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ %@",[firstNameObject getValue],[lastNameObject getValue]]];
    
    // Return the cell complete.
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    ODataEntry *entry = [self.results objectAtIndex:[indexPath row]];
    NSMutableDictionary *fields = [entry getFields];
    // Retrieve the value for employee ID
    ODataPropertyValueObject *idObject = [fields objectForKey:@"ID"];
    NSLog(@"row=%d, ID=%@",[indexPath row], [idObject getValue]);
    EmployeeDetailViewController *controller = [[EmployeeDetailViewController alloc] initWithNibName:@"EmployeeDetailViewController" bundle:Nil];
    controller.empId = [idObject getValue];
    controller.controller = self.controller;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - SMP delegate methods

// Callback for when the user-registration was OK.
- (void)userRegistrationSuccessful{
    [self.downloadDataButton setEnabled:YES];
    [self.registerButton setEnabled:NO];
}

// Callbcak for when the user-registration failed.
- (void)userRegistrationFailed:(NSString *)message{
    [self displayError:message];
}

// Callback for when we have received the data.
- (void)dataRetrievalComplete:(NSMutableArray *)results{
    // Update table here.
    self.results = results;
    NSLog(@"self.results=%@",[self.results description]);
    [self.resultsTable reloadData];
}

// Callback for when the data retrieval failed.
- (void)dataRetrievalFailed{
    [self displayError:@"Unable to retrieve data"];
}

#pragma mark - Button press actions
- (IBAction)startRegistration:(id)sender {
    
    NSError *error = [self.controller initialiseSMP];
    if (error) {
        [self displayError:[error debugDescription]];
    }
}

- (IBAction)startDataDownload:(id)sender {
    [self.controller beginDataRetrieval];
}
@end
