//
//  ViewController.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/20/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ViewController
{
    NSMutableArray *listInputText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set default for variables
    [self setDefaultForVariables];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: - Private method
- (void)setDefaultForVariables {
    //Initialization array
    listInputText = [NSMutableArray array];
    
    for (int i = 0; i < MAX_LINES_IN_TABLE ;i++) {
        Item *item = [[Item alloc] init];
        item.image = IMAGE_DEFAULT;
        item.textInput = @"";
        [listInputText addObject:item];
    }
}

#pragma mark: - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX_LINES_IN_TABLE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Item *item = (Item *)[listInputText objectAtIndex:indexPath.row];
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    cell.delegate = self;
    cell.currentIndexPath = indexPath;
    cell.mImageResult.image = item.image;
    cell.mTextFieldInput.text = item.textInput;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark: - CustomCell Delegate 
- (void)updateFrameWhenChangeImageAtIndexPath:(NSIndexPath *)indexPath andItem:(Item *)item{
    [self.mTableView beginUpdates];
    [self.mTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [listInputText replaceObjectAtIndex:indexPath.row withObject:item];
    [self.mTableView endUpdates];
}

@end
