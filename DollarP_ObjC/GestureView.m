#import "GestureView.h"

@implementation GestureView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    currentTouches = [[NSMutableDictionary alloc] init];
    completePoints = [NSMutableArray array];

    [self setBackgroundColor:[UIColor whiteColor]];
    [self setMultipleTouchEnabled:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    for (UITouch *touch in touches) {        
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        CGPoint location = [touch locationInView:self];
        NSMutableArray *points = [NSMutableArray arrayWithObject:
                                  [NSValue valueWithCGPoint:location]];
        [currentTouches setObject:points forKey:key];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        NSMutableArray *points = [currentTouches objectForKey:key];
        CGPoint location = [touch locationInView:self];
        [points addObject:[NSValue valueWithCGPoint:location]];
    }

    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    [self endTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];

    [self endTouches:touches];
}

- (void)endTouches:(NSSet *)touches {
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        NSMutableArray *points = [currentTouches objectForKey:key];
        
        if (points) {
            [completePoints addObject:points];
            [currentTouches removeObjectForKey:key];
        }
    }

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (int i = 0; i < [completePoints count]; i++) {
        NSMutableArray *points = [completePoints objectAtIndex:i];
        [self drawPoints:points withColor:[UIColor blackColor] inContext:context];
    }
    
    for (NSValue *touchValue in currentTouches) {
        NSMutableArray *points = [currentTouches objectForKey:touchValue];
        [self drawPoints:points withColor:[UIColor blueColor] inContext:context];
    }
}

- (void)drawPoints:(NSMutableArray *)points
         withColor:(UIColor *)color
         inContext:(CGContextRef)context {
    [color set];
    
    CGPoint point = [points[0] CGPointValue];
    
    CGContextMoveToPoint(context, point.x, point.y);
    for (int i = 1; i < [points count]; i++) {
        point = [points[i] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextStrokePath(context);
}

- (void)clearAll {
    [completePoints removeAllObjects];
    [currentTouches removeAllObjects];
    
    [self setNeedsDisplay];
}

@end