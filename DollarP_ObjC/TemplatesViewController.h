#import <UIKit/UIKit.h>

@interface TemplatesViewController : UIViewController <UIScrollViewDelegate> {
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIScrollView *scrollView;
}

- (IBAction)gotoWebsite:(id)sender;

@end