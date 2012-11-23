#import <Foundation/Foundation.h>

@interface GestureView : UIView {
    NSMutableDictionary *currentTouches;
    NSMutableArray *completePoints;
}

- (void)clearAll;

@end