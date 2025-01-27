//
//  ViewController.m
//  QarsaniOS
//
//  Created by Michael Weingert on 2015-04-11.
//  Copyright (c) 2015 PBC. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

#import "HeaderTableViewCell.h"
#import "NonHeaderTableViewCell.h"
//#import <Firebase/Firebase.h>
#import "FirebaseManager.h"
#import "ArticleViewController.h"
#import "ComposeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
  [self.tableView setContentInset:UIEdgeInsetsMake(63,0,0,0)];
    //[self.tableView setContentInset:UIEdgeInsetsMake(0,0,0,0)];
  
  /*UIBarButtonItem *addNewButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPost)];
  
  self.navigationItem.rightBarButtonItem = addNewButton;*/
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void) addNewPost
{
  //Perform segue here
  [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[FirebaseManager sharedManager] getNumberOfStories];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([indexPath row] == -1)
  {
    return UITableViewAutomaticDimension;
  } else {
    return 80;
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 44;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  ArticleViewController* destinationViewController = (ArticleViewController *)segue.destinationViewController;
  if (destinationViewController)
  {
    NonHeaderTableViewCell* senderCell = (NonHeaderTableViewCell *)sender;
    if (sender) {
      [destinationViewController initWithHeader:[senderCell getHeader] andArticleText:[senderCell getArticle] andImage:[senderCell getImage]];
      
      self.title = @"Home";
    }
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *headerTableCellIdentifier = @"HeaderCell";
  static NSString *notHeaderTableCellIdentifier = @"NotHeaderCell";
  
  if ([indexPath row] == -1)
  {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTableCellIdentifier];
    
    if (cell == nil) {
      cell = [[HeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerTableCellIdentifier];
    }
      //cell.textLabel.text = @"Header";
    
    return cell;
  } else {
    NonHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notHeaderTableCellIdentifier];
    
    if (cell == nil) {
      cell = [[NonHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:notHeaderTableCellIdentifier];
    }
    
    NSString * headline = [[FirebaseManager sharedManager] getHeadlineWithId:[NSNumber numberWithInt: [indexPath row]]];
    NSString * article = [[FirebaseManager sharedManager] getStoryWithId:[NSNumber numberWithInt: [indexPath row]]];
    NSString * category = [[FirebaseManager sharedManager] getCategoryWithId:[NSNumber numberWithInt: [indexPath row]]];
    [cell setHeadline:headline andArticle:article andCategory:category];
    
    return cell;
  }
 // return cell;
}

@end
