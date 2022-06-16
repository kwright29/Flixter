//
//  MovieCell.h
//  Flixter
//
//  Created by Khloe Wright on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *movieViewCell;
@property (strong, nonatomic) IBOutlet UIImageView *movieImageViewer;
@property (strong, nonatomic) IBOutlet UILabel *movieTitle;
@property (strong, nonatomic) IBOutlet UILabel *movieSynposis;

@end

NS_ASSUME_NONNULL_END
