//
//  DetailsViewController.m
//  Flixter
//
//  Created by Khloe Wright on 6/17/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _detailTitle.text = _movieDetails.title;
    _detailDescription.text = _movieDetails.synopsis;
    NSString *rd = @"Release Date: ";
    _detailRDate.text = [rd stringByAppendingString:_movieDetails.releaseDate];
    
    //loading poster image
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *urlString = _movieDetails.posterURL;
    NSString *fullURL = [baseURL stringByAppendingString:urlString];
    NSURL *url = [[NSURL alloc] initWithString:fullURL];
    
    [_detailPoster setImageWithURL:url];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
