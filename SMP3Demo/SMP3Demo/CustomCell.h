//
//  CustomCell.h
//  SMP3Demo
//
//  Created by Pronob Mukherjee on 15/05/14.
//  Copyright (c) 2014 BSIL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leaveType;
@property (weak, nonatomic) IBOutlet UILabel *leaveDuration;
@property (weak, nonatomic) IBOutlet UILabel *appliedOn;
@property (weak, nonatomic) IBOutlet UILabel *approvedOn;
@property (weak, nonatomic) IBOutlet UILabel *reason;
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
