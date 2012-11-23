#import "DollarPGestureRecognizer.h"
#import "DollarPoint.h"

@implementation DollarPGestureRecognizer

@synthesize pointClouds, result;

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        dollarP = [[DollarP alloc] init];
        currentTouches = [[NSMutableDictionary alloc] init];
        currentPoints = [NSMutableArray array];
        points = [NSMutableArray array];
    }
    return self;
}

- (void)reset {
    [super reset];
    [currentTouches removeAllObjects];
    [currentPoints removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    int index = 0;
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        [currentTouches setObject:[NSNumber numberWithInt:index] forKey:key];
        index++;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if ([self state] == UIGestureRecognizerStateFailed) {
        return;
    }
    
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        int index = [[currentTouches objectForKey:key] intValue];
        CGPoint location = [touch locationInView:[self view]];
        
        DollarPoint *point = [[DollarPoint alloc] initWithId:@(index)
                                                           x:location.x
                                                           y:location.y];
        [currentPoints addObject:point];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    [self setState:UIGestureRecognizerStateFailed];
}

- (void)recognize {
    if ([currentPoints count] == 0) {
        [self setState:UIGestureRecognizerStateFailed];
        return;
    }
    
    points = [currentPoints copy];
    
    if ([self state] == UIGestureRecognizerStatePossible) {
        result = [dollarP recognize:points];
        [self setState:UIGestureRecognizerStateRecognized];
    }
}

- (NSMutableArray *)pointClouds {
    return [dollarP pointClouds];
}

- (void)setPointClouds:(NSMutableArray *)somePointClouds {
    [dollarP setPointClouds:somePointClouds];
}

- (void)addGestureWithName:(NSString *)name {
    if ([points count] > 0) {
        [dollarP addGesture:name points:points];
    }
}

- (NSArray *)points {
    return points;
}

@end