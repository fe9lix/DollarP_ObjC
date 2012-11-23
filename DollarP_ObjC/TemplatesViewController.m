#import "TemplatesViewController.h"

@implementation TemplatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [scrollView setContentSize:[[imageView image] size]];
    [scrollView setDelegate:self];
    
    [imageView setFrame:CGRectMake(0, 0, [imageView image].size.width, [imageView image].size.height)];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imageView;
}

- (IBAction)gotoWebsite:(id)sender {
    NSURL *url = [[NSURL alloc] initWithString:@"http://depts.washington.edu/aimgroup/proj/dollar/pdollar.html"];
    [[UIApplication sharedApplication] openURL:url];
}

@end