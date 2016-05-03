//
//  NewItemPopoverViewController.m
//  ToDo
//
//  Created by Donny Davis on 5/3/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "NewItemPopoverViewController.h"

@interface NewItemPopoverViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIDatePicker *dueDatePicker;

@end

@implementation NewItemPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dueDatePicker.datePickerMode = UIDatePickerModeDate;
    self.dueDateTextField.inputView = self.dueDatePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.dueDateTextField) {
        if ([self.dueDateTextField.text isEqualToString:@""]) {
            [self.dueDatePicker setDate:[NSDate date] animated:YES];
        } else {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMddyyyy" options:0 locale:[NSLocale currentLocale]];
            [dateFormatter setDateFormat:formatString];
            [self.dueDatePicker setDate:[dateFormatter dateFromString:self.dueDateTextField.text] animated:YES];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.titleTextField]) {
        [self.titleTextField resignFirstResponder];
        [self.notesTextView becomeFirstResponder];
        return YES;
    } else if ([textField isEqual:self.notesTextView]) {
        [self.notesTextView resignFirstResponder];
        return YES;
    }
    
    return NO;
}

@end
