//
//  CustomCell.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/20/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell() <UITextFieldDelegate>

@end


@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //Set properties for view
    [self setPropertiesForView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark: - Private method
- (void)setPropertiesForView {
    // Set delegate for textView
    self.mTextFieldInput.delegate = self;
    
    // Set tap gesture for cell
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTextField:)];
    [self addGestureRecognizer:tap];
    
    // Set selector when text field changed
//    [self.mTextFieldInput addTarget:self action:@selector(editingChangedOnTextField:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark: - Selector method

- (void)resignTextField:(id)sender {
    [self.mTextFieldInput resignFirstResponder];
}


#pragma mark: - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length > 19) {
        if([string isEqualToString:@""] && range.length == 1) {
            //Tap delete button
            return true;
        } else {
            // More 20 characters
            return false;
        }
    }
    
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
}

@end
