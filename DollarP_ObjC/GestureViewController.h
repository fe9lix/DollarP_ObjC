#import <UIKit/UIKit.h>
#import "DollarPGestureRecognizer.h"
#import "GestureView.h"

@interface GestureViewController : UIViewController {
    DollarPGestureRecognizer *dollarPGestureRecognizer;
    __weak IBOutlet GestureView *gestureView;
    __weak IBOutlet UILabel *resultLabel;
    __weak IBOutlet UIToolbar *toolbar;
}

- (IBAction)recognize:(id)sender;

@end