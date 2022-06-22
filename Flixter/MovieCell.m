//
//  MovieCell.m
//  Flixter
//
//  Created by Khloe Wright on 6/16/22.
//

#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMovie: (Movie *)movie {
    _movie = movie;
    
    self.movieTitle.text = self.movie.title;
    self.movieSynposis.text = self.movie.synopsis;
    
    self.movieImageViewer.image = nil;
    if (self.movie.posterURL != nil) {
        [self.movieImageViewer setImageWithURL:self.movie.posterURL];
    }
}
@end
