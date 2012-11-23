#import <Foundation/Foundation.h>

@interface DollarPointCloud : NSObject 

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *points;

- (id)initWithName:(NSString *)aName points:(NSArray *)somePoints;

@end