//
//  ViewController.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/20/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "Item.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    Item *item = [[Item alloc] init];
    
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
    cell.mTextFieldInput.text = item.textInput;
    cell.mImageResult.image = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
