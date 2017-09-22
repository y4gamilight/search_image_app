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
#import "UIImageView+CircularProgressView.h"

@interface CustomCell() <UITextFieldDelegate,ProgressViewDataSource>

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
    if(self.mTextFieldInput.text.length > 0) {
        [self callAPIGetImageFirstWithKeyWord];
    } else {
        self.mImageResult.image = IMAGE_DEFAULT;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)callAPIGetImageFirstWithKeyWord {
    //Show hud
    
    //Initializable param
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"searchType"] = @"image"; //type search image
    params[@"q"]= self.mTextFieldInput.text;  //keyword search
    
    //Call API Search with param
    [[SearchImageAPI sharedObject] requestWithOptions:params success:^(API *sender, id result) {
        if( [result objectForKey:@"items"] ){
            //Array Items find out
            NSArray *arrayObj = (NSArray *)[result objectForKey:@"items"] ;
            ResultObj *obj = [[ResultObj alloc] initWithDictionary:arrayObj[0] error:nil];
            ImageObj *imgObj = obj.image;
            
            //Change frame image cell
            CGFloat widthImage = imgObj.width.floatValue;
            CGFloat heightImage = imgObj.height.floatValue;
            CGFloat widthOriginal = self.mImageResult.frame.size.width;
            CGFloat newHeight =  (widthOriginal/widthImage) * heightImage;
            self.mHeightConstraintCell.constant = newHeight;
            
            NSLog(@"obj : %@",imgObj.thumbnailLink);
            NSLog(@"width Original : %f",self.mImageResult.frame.size.width);
            
            NSURL *url = [NSURL URLWithString:imgObj.thumbnailLink];
            //Check url of image
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [self.mImageResult nkvSetProgressViewDataSource:self];
                [self.mImageResult nkv_setImageWithURL:url placeholderImage:IMAGE_DEFAULT options:SDWebImageProgressiveDownload progress:nil completed:
                 ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                     if(image) {
                         self.mImageResult.image = image;
                     }
                     if ([self.delegate respondsToSelector:@selector(updateFrameWhenChangeImageAtIndexPath:andItem:)]) {
                         Item *item = [[Item alloc] init];
                         item.image = self.mImageResult.image;
                         item.textInput = self.mTextFieldInput.text;
                         item.urlImage = imgObj.thumbnailLink;
                         [self.delegate updateFrameWhenChangeImageAtIndexPath:self.currentIndexPath andItem:item];
                     }
                 } usingProgressViewType:CircularPV orCustomProgressView:nil];
                
            }
        }
    } failure:^(API *sender, NSError *error) {
        NSString *message = error.localizedDescription;
        //Error limit by google ( 100 queries/day)
        if (error.code == CODE_ERROR_GOOGLE_API_403 ) {
            message = NSLocalizedString(@"error_message_code_403", nil);
        }
        [GlobalMethods showMessage:message];
    }];
}

@end
