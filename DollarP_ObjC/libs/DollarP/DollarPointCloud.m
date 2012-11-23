#import "DollarPointCloud.h"
#import "DollarP.h"

@implementation DollarPointCloud

@synthesize name, points;

- (id)initWithName:(NSString *)aName points:(NSArray *)somePoints {
    self = [super init];
    if (self) {
        [self setName:aName];
        
        somePoints = [DollarP resample:somePoints numPoints:DollarPNumPoints];
        somePoints = [DollarP scale:somePoints];
        somePoints = [DollarP translate:somePoints to:[DollarPoint origin]];
        
        [self setPoints:somePoints];
    }
    return self;
}

@end