//
//  DetailViewController.m
//  ToDo
//
//  Created by Donny Davis on 5/3/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIDatePicker *dueDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *clearDateButton;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSString *formatString;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.titleTextField.text = [self.detailItem valueForKey:@"title"];
        if ([self.detailItem valueForKey:@"dueDate"]) {
            self.dueDateTextField.text = [self.dateFormatter stringFromDate:[self.detailItem valueForKey:@"dueDate"]];
            self.clearDateButton.enabled = YES;
        }
        self.notesTextView.text = [self.detailItem valueForKey:@"notes"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.formatString = [NSDateFormatter dateFormatFromTemplate:@"MMddyy" options:0 locale:[NSLocale currentLocale]];
    [self.dateFormatter setDateFormat:self.formatString];
    
    [self configureView];
    
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

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    [self.detailItem setValue:self.titleTextField.text forKey:@"title"];
    if (![self.dueDateTextField.text isEqualToString:@""]) {
        [self.detailItem setValue:[self.dateFormatter dateFromString:self.dueDateTextField.text] forKey:@"dueDate"];
    }
    [self.detailItem setValue:self.notesTextView.text forKey:@"notes"];
    
    NSError *error;
    if (![self.detailItem.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.masterVC reloadTableAfterUpdate];
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
