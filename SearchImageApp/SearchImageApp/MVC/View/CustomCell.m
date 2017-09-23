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
{
    CGFloat scaleDisplay;
    NSString *currentStrAPI;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //Set varaible
    scaleDisplay = IS_IPHONE ? DISPLAY_SCALE : DISPLAY_SCALE_IPAD;
    
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
    NSLog(@"***resignTextField %@",self.mTextFieldInput.text);
    NSLog(@"indexPath %ld",self.currentIndexPath.row);
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
    NSLog(@"***EditingChangedOnTextField %@",self.mTextFieldInput.text);
    NSLog(@"indexPath %ld",self.currentIndexPath.row);
    currentStrAPI = self.mTextFieldInput.text;
    if(self.mTextFieldInput.text.length > 0) {
        [self callAPIGetImageFirstWithKeyWord];
    } else {
        self.mImageResult.image = IMAGE_DEFAULT;
        self.mHeightConstraintCell.constant = 140 * scaleDisplay;
        [self callDelegateUpdateItemOnCell:nil];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"***Call textField should return %@",textField.text);
    [textField resignFirstResponder];
    
    return true;
}

#pragma mark - CircleVC Datasource
- (CircularProgressViewSettings *)setupCircularProgressViewSettings
{
    CircularProgressViewSettings *circularSettings = [CircularProgressViewSettings new];
    circularSettings.progressTintColor = [UIColor redColor];
    circularSettings.thicknessRatio = 0.2;
    return circularSettings;
}

#pragma mark - Call PI
- (void)callAPIGetImageFirstWithKeyWord {
    //Show hud
    
    //Initializable param
    NSMutableDictionary *params = @{}.mutableCopy;
    params[@"searchType"] = @"image"; //type search image
    params[@"q"]= self.mTextFieldInput.text;  //keyword search
    
    //Call API Search with param
    [[SearchImageAPI sharedObject] requestWithOptions:params success:^(API *sender, id result) {
        //Get value request infomation
        NSArray *arrayRequest = (NSArray *)[[result objectForKey:@"queries"] objectForKey:@"request"];
        //Get key search with this api
        NSString *requestKey = [[arrayRequest objectAtIndex:0] objectForKey:@"searchTerms"];
        //Get total result of request
        NSInteger totalResults = [[[arrayRequest objectAtIndex:0] objectForKey:@"totalResults"] integerValue];
        
        [GlobalMethods resetStatusKeyGoogleAPI];
        if([currentStrAPI isEqualToString:requestKey]){
            if (totalResults <= 0) {
                //Not found
                NSString *message = [NSString stringWithFormat:NSLocalizedString(@"error_message_no_found",nil) ,requestKey];
                [GlobalMethods showMessage:message];
            } else {
                //Found
                //Array Items find out
                NSLog(@"Match keycurrent");
                NSArray *arrayObj = (NSArray *)[result objectForKey:@"items"] ;
                ResultObj *obj = [[ResultObj alloc] initWithDictionary:arrayObj[0] error:nil];
                ImageObj *imgObj = obj.image;
                
                //Change frame image cell
                CGFloat widthImage = imgObj.width.floatValue;
                CGFloat heightImage = imgObj.height.floatValue;
                CGFloat widthOriginal = 186 * scaleDisplay;
                CGFloat newHeight =  (widthOriginal/widthImage) * heightImage;
                self.mHeightConstraintCell.constant = newHeight;
                
                NSLog(@"obj : %@",imgObj.thumbnailLink);
                NSLog(@"width Original : %f",self.mImageResult.frame.size.width);
                
                NSURL *url = [NSURL URLWithString:imgObj.thumbnailLink];
                //Check url of image
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    //Set HUD for image
                    [self.mImageResult nkvSetProgressViewDataSource:self];
                    //Set Image with url
                    [self.mImageResult nkv_setImageWithURL:url placeholderImage:IMAGE_DEFAULT options:SDWebImageProgressiveDownload progress:nil completed:
                     ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                         if(image) {
                             self.mImageResult.image = image;
                         }
                         
                         //call back to update item of cell
                         [self callDelegateUpdateItemOnCell:imgObj.thumbnailLink];
                         
                     } usingProgressViewType:CircularPV orCustomProgressView:nil];
                    
                }
            }
          
        }
    } failure:^(API *sender, NSError *error) {
        NSString *message = error.localizedDescription;
        //Error limit by google ( 100 queries/day)
        if (error.code == CODE_ERROR_GOOGLE_API_403 ) {
            if( [GlobalMethods isEnableKeyGoogleAPI]) {
                message = nil;
                [self callAPIGetImageFirstWithKeyWord];
            } else {
                message = NSLocalizedString(@"error_message_code_403", nil);
            }
        } else {
            [GlobalMethods resetStatusKeyGoogleAPI];
        }
        if(message){
            [GlobalMethods showMessage:message];
        }
    }];
}


- (void)callDelegateUpdateItemOnCell:(NSString *)url {
    if ([self.delegate respondsToSelector:@selector(updateFrameWhenChangeImageAtIndexPath:andItem:)]) {
        Item *item = [[Item alloc] init];
        item.image = self.mImageResult.image;
        item.textInput = self.mTextFieldInput.text;
        item.urlImage = url;
        [self.delegate updateFrameWhenChangeImageAtIndexPath:self.currentIndexPath andItem:item];
    }
}
@end
