#import <UIKit/UIKit.h>
#import "DollarPGestureRecognizer.h"

@interface CustomizeViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate> {
    __weak IBOutlet UIPickerView *existingTypesPicker;
    __weak IBOutlet UITextField *customTypeField;
}

@property (nonatomic, strong) DollarPGestureRecognizer *gestureRecognizer;

- (IBAction)addToExistingType:(id)sender;
- (IBAction)addToCustomType:(id)sender;
- (IBAction)deleteAllCustomTypes:(id)sender;

@end