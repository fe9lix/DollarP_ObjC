#import "DollarPoint.h"

@implementation DollarPoint

@synthesize x, y, id;

+ (DollarPoint *)origin {
    static DollarPoint *origin = nil;
    if (!origin) {
        origin = [[DollarPoint alloc] initWithId:0
                                               x:0.0f
                                               y:0.0f];
    }
    return origin;
}

- (id)initWithId:(id)anId x:(float)aX y:(float)aY {
    self = [super init];
    if (self) {
        [self setId:anId];
        [self setX:aX];
        [self setY:aY];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    DollarPoint *point = [[DollarPoint alloc] init];
    
    [point setX:[self x]];
    [point setY:[self y]];
    [point setId:[self id]];
    
    return point;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"id:%@ x:%f y:%f",
            [self id], [self x], [self y]];
}

@end