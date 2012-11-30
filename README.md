# $P Point-Cloud Recognizer for Objective-C

An Objective-C port of the $P gesture recognizer to be used in iOS applications.

![Demo App](https://raw.github.com/fe9lix/DollarP_ObjC/gh-pages-data/images/dollarp-objc-demo-app.png)

## What is $P?
From the [$P website](http://depts.washington.edu/aimgroup/proj/dollar/pdollar.html):

> The $P Point-Cloud Recognizer is a 2-D gesture recognizer designed for rapid prototyping of gesture-based user interfaces. In machine learning terms, $P is an instance-based nearest-neighbor classifier with a Euclidean scoring function, i.e., a geometric template matcher. $P is the latest in the dollar family of recognizers that includes $1 for unistrokes and $N for multistrokes. Although about half of $P's code is from $1, unlike both $1 and $N, $P does not represent gestures as ordered series of points (i.e., strokes), but as unordered point-clouds. By representing gestures as point-clouds, $P can handle both unistrokes and multistrokes equivalently and without the combinatoric overhead of $N. When comparing two point-clouds, $P solves the classic assignment problem between two bipartite graphs using an approximation of the Hungarian algorithm. The $P recognizer is distributed under the New BSD License agreement.

## How to use
All gesture recognizer files are located in `libs/DollarP`. Just drag this folder into your Xcode project. See the code of the demo app on how to use the recognizer. 
`GestureViewController.m` is the implementation file where a new recognizer is added to the view:


```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(gestureRecognized:)];

    [gestureView addGestureRecognizer:dollarPGestureRecognizer];
}
```

If you want to add the default templates:
```objective-c
[dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
```

When a gesture is recognized, a `DollarPResult` object contains the name and score of the gesture:
```objective-c
- (void)gestureRecognized:(DollarPGestureRecognizer *)sender {
    DollarResult *result = [sender result];
    [resultLabel setText:[NSString stringWithFormat:@"Result: %@ (Score: %.2f)",
                          [result name], [result score]]];
}
```

Since the recognizer does not continuously calculate possible gestures, you need to call `recognize` at some point:
```objective-c
[dollarPGestureRecognizer recognize];
```

(Depending on your needs, you could also extend `DollarPGestureRecognizer` to perform the recognition in the `touchesEnded` delegate method.)

###Adding your own templates:

`See CustomizeViewController.m`. You can either add preprocessed templates (`DollarPointCloud`) or add new templates on the fly.
To add all current points as a gesture:
```objective-c
[gestureRecognizer addGestureWithName:name];
```

`DollarDefaultGestures.m` shows you how to add a new preprocessed template:
```objective-c
NSArray *points = @[
    [[DollarPoint alloc] initWithId:@1 x:0 y:100],
    [[DollarPoint alloc] initWithId:@1 x:50 y:0],
    [[DollarPoint alloc] initWithId:@2 x:50 y:0],
    [[DollarPoint alloc] initWithId:@2 x:100 y:100]
];
DollarPointCloud *pointCloud = [[DollarPointCloud alloc] initWithName:@"Roof" points:points];
[[dollarPGestureRecognizer pointClouds] addObject:pointCloud];
```
This would add a new gesture called "Roof" with two different strokes consisting of two points each as a new preprocessed template.

###Using DollarP directly:
`DollarPGestureReconizer` is just a "facade" for `DollarP`, integrated into iOS gesture recognizers. 
However, you could also use `DollarP` directly and write your own recognizer on top of it using the methods `addGesture`, `recognize` and the property `pointClouds` from `DollarP.h`.

## Notes (Demo App):
* You need to add additional templates to improve gesture scores (`Customize/Add to existing type`).
* Custom templates are not persisted between launches!
* Template images on the start screen are displayed from a static image of the $P website and not generated dynamically.