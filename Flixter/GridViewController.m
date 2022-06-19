//
//  GridViewController.m
//  Flixter
//
//  Created by Khloe Wright on 6/19/22.
//

#import "GridViewController.h"
#import "GridCell.h"
#import "MovieViewController.m"
#import "UIImageView+AFNetworking.h"

@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *gridCollectionView;
@property (strong, nonatomic) NSArray *moviePosters;
@property (strong, nonatomic) NSDictionary *dataDictionary;

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gridCollectionView.dataSource = self;
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               
           }
           else {
               self.dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", self.dataDictionary);// log an object with the %@ formatter.
               
               // TODO: Get the array of movies
               
               self.moviePosters = self.dataDictionary[@"poster_path"];
               //NSArray *movies = dataDictionary[@"results"];
               
               
               // TODO: Reload your collection view data
               
               [self.gridCollectionView reloadData];
               //hides automatically if "Hides When Stopped" is enables
               
           }
       }];
    [task resume];

    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.moviePosters.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
    
    
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *urlString = _moviePosters[indexPath.row];
    NSString *fullURL = [baseURL stringByAppendingString:urlString];
    NSURL *url = [[NSURL alloc] initWithString:fullURL];
    
    [cell.gridPoster setImageWithURL:url];
    return cell;
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
