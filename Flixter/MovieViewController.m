//
//  MovieViewController.m
//  Flixter
//
//  Created by Khloe Wright on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"


@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> // this class implements this protocol. we will implement these methods in our code

// table view data source = shows content
// delegate = i know how to respond to table view events

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refreshControl; //made refreshControl varibale accessible to whole file since different methods are using it
@property (strong, nonatomic) NSDictionary *dataDictionary;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // initializing UIRefresh Control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged]; //bind action to refresh control
    [self.tableView insertSubview:self.refreshControl atIndex:0]; //inserts the refresh control into the table view
    //needs bottom inequality constraints for any views that may be the bottom most view
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;  
    self.tableView.delegate = self;
    // Do any additional setup after loading the view.
    
    //activity indicators 
    [self.activityIndicator startAnimating];
    
    [self loadData];
    
    
    
}

- (void)loadData {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                          message:@"The internet connection appears to be offline"
                                          preferredStyle:UIAlertControllerStyleAlert];

               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction * action) {[self loadData];}]; //reloading data after pressing Try Again to see if we can fetch movies

               [alert addAction:defaultAction];
               [self presentViewController:alert animated:YES completion:nil];
               
           }
           else {
               [self.activityIndicator stopAnimating];
               self.dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@", self.dataDictionary);// log an object with the %@ formatter.
               
               // TODO: Get the array of movies
               
               self.movies = self.dataDictionary[@"results"];
               //NSArray *movies = dataDictionary[@"results"];
               
               // TODO: Store the movies in a property to use elsewhere
               
               for (NSDictionary *movie in self.movies) {
                   NSLog(@"%@", movie[@"title"]);
               }
                //NSLog(@"%@", movies);
               
               
               // TODO: Reload your table view data
               
               [self beginRefresh:self.refreshControl];
               //hides automatically if "Hides When Stopped" is enables
               
           }
       }];
    [task resume];
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
   // TODO: Reload your table view data
   [self.tableView reloadData]; //reloading because data may have changed
   [refreshControl endRefreshing];
       
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count; // tying to data
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    // using indexPath
    NSDictionary *movie = self.movies[indexPath.row];
    // loading each poster image
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *urlString = movie[@"poster_path"];
    NSString *fullURL = [baseURL stringByAppendingString:urlString];
    NSURL *url = [[NSURL alloc] initWithString:fullURL];
    
    [cell.movieImageViewer setImageWithURL:url];
    
    
    cell.movieSynposis.text = movie[@"overview"];
    
    cell.movieTitle.text = movie[@"title"];
    
    
    
    
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *myIndexPath = [self.tableView indexPathForCell:sender];
    NSDictionary *dataToPass = self.movies[myIndexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
    
}


@end
