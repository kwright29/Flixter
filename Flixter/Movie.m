//
//  Movie.m
//  Flixter
//
//  Created by Khloe Wright on 6/22/22.
//

#import "Movie.h"

@implementation Movie
-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    NSString *baseURL = @"https://image.tmdb.org/t/p/w500";
    NSString *path = dictionary[@"poster_path"];
    NSString *fullURL = [baseURL stringByAppendingString:path];
    NSURL *url = [[NSURL alloc] initWithString:fullURL];
    
    self.title = dictionary[@"title"];
    self.posterURL = url;
    self.synopsis = dictionary[@"overview"];
    self.releaseDate = dictionary[@"release_date"];
    
    
    return self;
}

+ (NSMutableArray *)moviesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return movies;
}


@end
