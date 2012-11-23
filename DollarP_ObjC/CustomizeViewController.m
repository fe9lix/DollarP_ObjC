#import "CustomizeViewController.h"
#import "DollarDefaultGestures.h"

@implementation CustomizeViewController

@synthesize gestureRecognizer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [existingTypesPicker setDelegate:self];
    [existingTypesPicker setDataSource:self];
    [existingTypesPicker selectRow:[self selectedTypeIndex] inComponent:0 animated:YES];
    
    [customTypeField setDelegate:self];
}

- (NSInteger)selectedTypeIndex {
    NSArray *pointClouds = [gestureRecognizer pointClouds];
    
    NSUInteger index = [pointClouds indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [[obj name] isEqualToString:[[gestureRecognizer result] name]];
    }];
    if (index != NSNotFound) {
        return index;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [[gestureRecognizer pointClouds] count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    UILabel* labelView;
    if (view) {
        labelView = (UILabel *)view;
    } else  {
        labelView = [[UILabel alloc] init];
    }
    
    NSString *label = [[[gestureRecognizer pointClouds] objectAtIndex:row] name];
    
    [labelView setText:label];
    [labelView setBackgroundColor:[UIColor clearColor]];
    [labelView sizeToFit];
    
    return labelView;
}

- (IBAction)addToExistingType:(id)sender {
    NSInteger selectedRowIndex = [existingTypesPicker selectedRowInComponent:0];
    UILabel *selectedLabel = (UILabel *)[existingTypesPicker viewForRow:selectedRowIndex forComponent:0];
    
    [gestureRecognizer addGestureWithName:[selectedLabel text]];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)addToCustomType:(id)sender {
    NSString *customType = [customTypeField text];
    if ([customType length] == 0) {
        return;
    }
    
    [gestureRecognizer addGestureWithName:customType];
    
    [existingTypesPicker reloadAllComponents];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)deleteAllCustomTypes:(id)sender {
    [gestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    
    [existingTypesPicker reloadAllComponents];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end