//
//  DetailsViewController.h
//  Flixter
//
//  Created by Khloe Wright on 6/17/22.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *detailTitle;
@property (strong, nonatomic) IBOutlet UIImageView *detailPoster;
@property (strong, nonatomic) IBOutlet UILabel *detailDescription;
@property (strong, nonatomic) IBOutlet UILabel *detailRDate;
@property (strong, nonatomic) Movie *movieDetails;

@end

NS_ASSUME_NONNULL_END
