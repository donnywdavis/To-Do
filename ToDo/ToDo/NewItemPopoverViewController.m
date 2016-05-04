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
@property (weak, nonatomic) IBOutlet UIButton *clearDateButton;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSString *formatString;

@end

@implementation NewItemPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.formatString = [NSDateFormatter dateFormatFromTemplate:@"MMddyy" options:0 locale:[NSLocale currentLocale]];
    [self.dateFormatter setDateFormat:self.formatString];
    
    self.dueDatePicker = [[UIDatePicker alloc] init];
    [self.dueDatePicker addTarget:self action:@selector(dueDateChanged) forControlEvents:UIControlEventValueChanged];
    self.dueDatePicker.datePickerMode = UIDatePickerModeDate;
    self.dueDateTextField.inputView = self.dueDatePicker;
    
    [self.titleTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dueDateChanged {
    self.dueDateTextField.text = [self.dateFormatter stringFromDate:self.dueDatePicker.date];
    self.clearDateButton.enabled = YES;
}

#pragma mark - Button Actions
- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clearDateAction:(UIButton *)sender {
    self.dueDateTextField.text = nil;
    self.clearDateButton.enabled = NO;
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.dueDateTextField) {
        if ([self.dueDateTextField.text isEqualToString:@""]) {
            [self.dueDatePicker setDate:[NSDate date] animated:YES];
        } else {
            [self.dueDatePicker setDate:[self.dateFormatter dateFromString:self.dueDateTextField.text] animated:YES];
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
