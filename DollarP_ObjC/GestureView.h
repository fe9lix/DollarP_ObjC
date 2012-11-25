#import <Foundation/Foundation.h>

@interface GestureView : UIView {
    NSMutableDictionary *currentTouches;
    NSMutableArray *completeStrokes;
}

- (void)clearAll;

@end