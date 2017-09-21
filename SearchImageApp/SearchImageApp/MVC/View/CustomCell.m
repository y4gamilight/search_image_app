//
//  CustomCell.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/20/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "CustomCell.h"
#import "SearchImageAPI.h"
#import "ResultObj.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
    [self.mTextFieldInput addTarget:self action:@selector(editingChangedOnTextField:) forControlEvents:UIControlEventEditingChanged];
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

- (void)editingChangedOnTextField:(id)sender {
    [self callAPIGetImageFirstWithKeyWord];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)callAPIGetImageFirstWithKeyWord {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"searchType"] = @"image";
    params[@"q"]= self.mTextFieldInput.text;
    [[SearchImageAPI sharedObject] requestWithOptions:params success:^(API *sender, id result) {
        if( [result objectForKey:@"items"] ){
            NSArray *arrayObj = (NSArray *)[result objectForKey:@"items"] ;
            ResultObj *obj = [[ResultObj alloc] initWithDictionary:arrayObj[0] error:nil];
            NSLog(@"obj : %@",obj.link);
            [self.mImageResult sd_setImageWithURL:obj.link completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image) {
                    self.mImageResult.image = image;
                } else {
                    self.mImageResult.image = nil;
                }
            }];
        }
    } failure:^(API *sender, NSError *error) {
        [GlobalMethods showMessage:error.description];
    }];
}

@end
