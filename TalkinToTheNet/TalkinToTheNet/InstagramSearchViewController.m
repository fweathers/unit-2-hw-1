//
//  InstagramSearchViewController.m
//  TalkinToTheNet
//
//  Created by Felicia Weathers on 9/29/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramSearchViewController.h"
#import "ItemSearchResults.h"
#import "ItemSearchViewController.h"
#import "InstagramPost.h"

@interface InstagramSearchViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic) NSDictionary *instagramPost;

@property (nonatomic) NSString *foursquareName;

@end

@implementation InstagramSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.dataCarriedOver.name;
    
    
    NSLog(@"%@", self.instagramPost);
    
    NSDictionary *images = [self.instagramPost objectForKey: @"images"];
    NSDictionary *sr = [images objectForKey:@"standard_resolution"];
    NSString *urlString = [sr objectForKey:@"url"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *pictureData = [NSData dataWithContentsOfURL:url];
    UIImage *picture = [UIImage imageWithData:pictureData];
    _imageView.image = picture;
}


#pragma mark: Instagram Info

- (void)makeNewViewWithPictureFromIG:(NSString *)searchWord
                       callbackBlock:(void(^)())block {
    
    
    NSString *instagramURLString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067",searchWord];

}

//- (void)fetchInstagramData {
//    //create instagram url
////    NSURL *instagramURL = [NSURL URLWithString:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067",  ];
//    
//    //fetch data from the instagram endpoint and print json response
////    [APIManager GETRequestWithURL:instagramURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        
//        //        self.instagramData = [json objectForKey:@"data"];
//        
//        [self.tableView reloadData];
//        
//    }];
//    
//}




@end
