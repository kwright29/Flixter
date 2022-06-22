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
    
    self.title = dictionary[@"title"];
    self.posterURL = dictionary[@"poster_path"];
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
