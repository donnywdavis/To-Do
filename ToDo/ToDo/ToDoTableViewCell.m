//
//  ToDoTableViewCell.m
//  ToDo
//
//  Created by Donny Davis on 5/3/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "ToDoTableViewCell.h"
#import "MasterViewController.h"

@implementation ToDoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkMarkButtonTapped:(UIButton *)sender {
    
    if (sender.selected) {
        [sender setSelected:NO];
    } else {
        [sender setSelected:YES];
    }
}

@end
