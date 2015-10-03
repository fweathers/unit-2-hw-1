//
//  InstagramSearchViewController.m
//  TalkinToTheNet
//
//  Created by Felicia Weathers on 9/29/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramSearchViewController.h"
#import "ItemSearchViewController.h"

@interface InstagramSearchViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic) NSDictionary *instagramPost;

@property (nonatomic) NSString *foursquareName;

@property (nonatomic) NSMutableArray *instagramResultsPost;

@end

@implementation InstagramSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"here - %@", self.tagName);
    self.nameLabel.text = self.tagName;
    
    [self fetchInstagramData];
    
}


#pragma mark: Instagram Info

//- (void)makeNewViewWithPictureFromIG:(NSString *)searchWord
//                       callbackBlock:(void(^)())block {
//    
//    
//    NSString *instagramURLString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067",searchWord];
//    
//    
//}

- (void)fetchInstagramData {
    
    NSString *passedName = [self.tagName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *emptyPassedName = [passedName stringByReplacingOccurrencesOfString:@"'" withString:@""];
    
    NSString *url = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ac0ee52ebb154199bfabfb15b498c067", emptyPassedName];
    
    //create instagram url
    NSURL *instagramURL = [NSURL URLWithString:url];
    NSLog(@"ig url = %@", instagramURL);
    
    //fetch data from the instagram endpoint and print json response
    [APIManager GETRequestWithURL:instagramURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data !=nil) {
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"json = %@", json);
            
            NSArray *instagramResults = json[@"data"];
            NSLog(@"instagramResults = %@", instagramResults);
            
            //create array
            self.instagramResultsPost = [[NSMutableArray alloc]init];
            
            for (NSDictionary *result in instagramResults) {
                
                NSDictionary *images = [result objectForKey: @"images"];
                NSDictionary *sr = [images objectForKey:@"standard_resolution"];
                NSString *urlString = [sr objectForKey:@"url"];
                NSLog(@"%@", urlString);
                NSURL *url = [NSURL URLWithString:urlString];
                NSData *pictureData = [NSData dataWithContentsOfURL:url];
                UIImage *picture = [UIImage imageWithData:pictureData];
                _imageView.image = picture;
                break;
            }
            
            //            [self.imageView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
}




@end
