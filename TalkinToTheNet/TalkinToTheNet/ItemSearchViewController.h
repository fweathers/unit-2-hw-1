//
//  ItemSearchViewController.h
//  TalkinToTheNet
//
//  Created by Felicia Weathers on 9/21/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemSearchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textSearchField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic)NSString *name;
@property (nonatomic)NSString *formattedPhone;


@property (nonatomic) NSMutableArray *searchResults;


@end
