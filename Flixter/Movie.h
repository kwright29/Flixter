//
//  Movie.h
//  Flixter
//
//  Created by Khloe Wright on 6/22/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *posterURL;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *releaseDate;


- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
