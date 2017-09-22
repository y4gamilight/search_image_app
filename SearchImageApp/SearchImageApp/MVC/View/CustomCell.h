//
//  CustomCell.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/20/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol CustomCellDelegate <NSObject>

- (void)updateFrameWhenChangeImageAtIndexPath:(NSIndexPath *)indexPath andItem:(Item *)item;

@end

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mHeightConstraintCell;

@property (weak, nonatomic) IBOutlet UITextField *mTextFieldInput;
@property (weak, nonatomic) IBOutlet UIImageView *mImageResult;

@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@property (weak, nonatomic) id <CustomCellDelegate> delegate;
@end
