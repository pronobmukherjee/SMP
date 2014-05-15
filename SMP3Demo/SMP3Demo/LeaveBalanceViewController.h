//
//  LeaveBalanceViewController.h
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 15/05/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPDelegate.h"
#import "SMPController.h"

@interface LeaveBalanceViewController : UIViewController<smpDelegate>

@property (weak, nonatomic) IBOutlet UILabel *SL;
@property (weak, nonatomic) IBOutlet UILabel *CL;
@property (weak, nonatomic) IBOutlet UILabel *PL;
@property (weak, nonatomic) IBOutlet UILabel *ASL;

// Our SMP Controller instance.
@property (strong, nonatomic) SMPController *controller;

// The array in which we will store our results.
@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) NSString *empId;

@end
