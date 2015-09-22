//
//  ItemSearchViewController.m
//  TalkinToTheNet
//
//  Created by Felicia Weathers on 9/21/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "ItemSearchViewController.h"
#import "APIManager.h"
#import "ItemSearchResults.h"

@interface ItemSearchViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>

@property (weak, nonatomic) IBOutlet UITextField *textSearchField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *searchResults;

@end

@implementation ItemSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.textSearchField.delegate = self;

}

- (void)makeNewLocationRequestWithSearchTerm:(NSString *)searchTerm
                             callbackBlock:(void(^)())block {
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=BLLBTLNEPSSZIEBWUOADOTUJEILKQUCW0HY002GHC0LMXUIJ&client_secret=EVG2DX3I0VTK2SWCCZVAYYMIMXRTYPGXPWRID4GUVFA54JJC&v=20130815&ll=40.7,-74&query=%@", searchTerm];
    
    NSString *encodedString= [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"%@", encodedString);
    
    //convert urlString to url
    NSURL *url = [NSURL URLWithString:encodedString];
    
    //make the request
    
    [APIManager GETRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         
         if (data != nil) {
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSLog(@"%@", json);
             
             NSArray *response = [json objectForKey:@"response"];
//             NSArray *contact = [json objectForKey:@"contact"];
//             NSArray *formattedPhone = [json objectForKey:@"formattedPhone"];
             NSArray *venue = [response valueForKey:@"venues"];
             
             self.searchResults = [[NSMutableArray alloc]init];
             for (NSDictionary *venues in venue) {
                 
                 NSString *name = [venues objectForKey:@"name"];
//                 NSString *contact = [venues objectForKey:@"contact"];
                 
                 ItemSearchResults *searchObject = [[ItemSearchResults alloc]init];
                 searchObject.name = name;
//                 searchObject.formattedPhone = formattedPhone;
                 
                 [self.searchResults addObject:searchObject];
             }
             
             block();
         }
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    NSInteger row = (NSInteger) [indexPath row];
    ItemSearchResults *currentResult = self.searchResults[row];
    cell.textLabel.text = currentResult.name;
    cell.detailTextLabel.text = currentResult.formattedPhone;
    
    return cell;
}

#pragma mark - text field delegate

// user tapped return
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //dismiss the keyboard
    [self.view endEditing:YES];
    
    //make an API request
    [self makeNewLocationRequestWithSearchTerm:textField.text callbackBlock:^{
        [self.tableView reloadData];
    }];
    
    return YES;
}

@end
