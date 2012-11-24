#import "GestureViewController.h"
#import "DollarDefaultGestures.h"
#import "DollarResult.h"
#import "CustomizeViewController.h"

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(gestureRecognized:)];
    [dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [dollarPGestureRecognizer setDelaysTouchesEnded:NO];

    [gestureView addGestureRecognizer:dollarPGestureRecognizer];
}

- (IBAction)recognize:(id)sender {
    if (recognized) {
        [gestureView clearAll];
        [resultLabel setText:@"Draw..."];
    } else {
        [dollarPGestureRecognizer recognize];
    }
    
    recognized = !recognized;
    
    [recognizeButton setTitle:recognized ? @"Clear" : @"Recognize"];
    [gestureView setUserInteractionEnabled:!recognized];
}

- (void)gestureRecognized:(DollarPGestureRecognizer *)sender {
    DollarResult *result = [sender result];
    [resultLabel setText:[NSString stringWithFormat:@"Result: %@ (Score: %.2f)",
                          [result name], [result score]]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"CustomizeViewController"]) {
        CustomizeViewController *customizeViewController = [segue destinationViewController];
        [customizeViewController setGestureRecognizer:dollarPGestureRecognizer];
    }
}

@end