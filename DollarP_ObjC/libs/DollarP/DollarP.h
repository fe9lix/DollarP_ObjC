#import <Foundation/Foundation.h>
#import "DollarResult.h"
#import "DollarPoint.h"

extern int const DollarPNumPoints;

@interface DollarP : NSObject;

@property (nonatomic, strong) NSMutableArray *pointClouds;

+ (NSArray *)resample:(NSArray *)points numPoints:(int)numPoints;
+ (NSArray *)scale:(NSArray *)points;
+ (NSArray *)translate:(NSArray *)points to:(DollarPoint *)point;

- (DollarResult *)recognize:(NSArray *)points;
- (void)addGesture:(NSString *)name points:(NSArray *)points;

@end