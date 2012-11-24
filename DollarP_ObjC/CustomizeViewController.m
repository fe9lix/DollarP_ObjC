#import "CustomizeViewController.h"
#import "DollarDefaultGestures.h"

@implementation CustomizeViewController

@synthesize gestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updatePointCloudNames];
    
    [existingTypesPicker setDelegate:self];
    [existingTypesPicker setDataSource:self];
    [existingTypesPicker selectRow:[self selectedTypeIndex]
                       inComponent:0
                          animated:YES];
    
    [customTypeField setDelegate:self];
}

- (void)updatePointCloudNames {
    pointCloudNames = [NSMutableArray array];
    pointCloudCount = [[NSCountedSet alloc] init];
    
    for (id pointCloud in [gestureRecognizer pointClouds]) {
        if (![pointCloudNames containsObject:[pointCloud name]]) {
            [pointCloudNames addObject:[pointCloud name]];
        }
        [pointCloudCount addObject:[pointCloud name]];
    }
}

- (NSInteger)selectedTypeIndex {    
    NSUInteger index = [pointCloudNames indexOfObjectPassingTest:
    ^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isEqualToString:[[gestureRecognizer result] name]];
    }];
    if (index != NSNotFound) {
        return index;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [pointCloudNames count];
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
    
    NSString *label = [pointCloudNames objectAtIndex:row];
    label = [label stringByAppendingString:[NSString stringWithFormat:@" (%d)",
                                    [pointCloudCount countForObject:label]]];
    
    [labelView setText:label];
    [labelView setBackgroundColor:[UIColor clearColor]];
    [labelView sizeToFit];
    
    return labelView;
}

- (IBAction)addToExistingType:(id)sender {
    NSInteger selectedRowIndex = [existingTypesPicker selectedRowInComponent:0];
    NSString *selectedName = [pointCloudNames objectAtIndex:selectedRowIndex];
    
    [self addGesture:selectedName];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)addToCustomType:(id)sender {
    NSString *customType = [customTypeField text];
    if ([customType length] == 0) {
        return;
    }
    
    [self addGesture:customType];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)addGesture:(NSString *)name {
    [gestureRecognizer addGestureWithName:name];
    [self updatePointCloudNames];
    [existingTypesPicker reloadAllComponents];
}

- (IBAction)deleteAllCustomTypes:(id)sender {
    [gestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [self updatePointCloudNames];
    [existingTypesPicker reloadAllComponents];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end