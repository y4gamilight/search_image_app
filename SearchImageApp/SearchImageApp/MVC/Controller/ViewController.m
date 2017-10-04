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
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIView *mViewTopLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mBottomConstraintTableView;

@end

@implementation ViewController
{
    NSMutableArray *listInputText;
    CGFloat scaleDisplay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set default for variables
    [self setDefaultForVariables];
    [self setGestureForViews];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self addObserverForViewController];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self removeObserverForViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark: - Private method
- (void)setDefaultForVariables {
    //Initialization array
    scaleDisplay = IS_IPHONE ? DISPLAY_SCALE : DISPLAY_SCALE_IPAD;
    
    listInputText = [NSMutableArray array];
    
    for (int i = 0; i < MAX_LINES_IN_TABLE ;i++) {
        Item *item = [[Item alloc] init];
        item.image = IMAGE_DEFAULT;
        item.textInput = @"";
        item.heightImage = 140 * scaleDisplay;
        [listInputText addObject:item];
    }
}

- (void)setGestureForViews {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardWillBeHidden)];
    [self.view addGestureRecognizer:tap];
}

- (void) addObserverForViewController{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsShown) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardIsHidden) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangedFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void) removeObserverForViewController {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
     
}

#pragma mark: - Selector
- (void)keyboardIsShown {
}

- (void)keyboardIsHidden {
    self.mBottomConstraintTableView.constant = 0;
}

- (void)keyBoardChangedFrame:(NSNotification *)notification {
    CGSize keyboardSize =  [[[notification userInfo]
                             objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    
    CGFloat height = MIN(keyboardSize.height,keyboardSize.width);
    self.mBottomConstraintTableView.constant = height;
    //
}

- (void)keyBoardWillBeHidden {
    [self.mTableView endEditing:true];
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
    [cell updateCellWithItem:item andIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
