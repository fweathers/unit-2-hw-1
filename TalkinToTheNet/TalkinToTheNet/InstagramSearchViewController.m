//
//  InstagramSearchViewController.m
//  TalkinToTheNet
//
//  Created by Felicia Weathers on 9/29/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "InstagramSearchViewController.h"

@interface InstagramSearchViewController ()

@end

@implementation InstagramSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.instagramPost);
    
    NSDictionary *images = [self.instagramPost objectForKey: @"images"];
    NSDictionary *sr = [images objectForKey:@"standard_resolution"];
    NSString *urlString = [sr objectForKey:@"url"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *pictureData = [NSData dataWithContentsOfURL:url];
    UIImage *picture = [UIImage imageWithData:pictureData];
    _imageView.image = picture;
}

@end
