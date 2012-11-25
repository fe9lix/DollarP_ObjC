#import "DollarP.h"
#import "DollarPointCloud.h"

int const DollarPNumPoints = 32;

@implementation DollarP

@synthesize pointClouds;

- (id)init {
    self = [super init];
    if (self) {
        pointClouds = [NSMutableArray array];
    }
    return self;
}

- (DollarResult *)recognize:(NSArray *)points {
    DollarResult *result = [[DollarResult alloc] init];
    [result setName:@"No match"];
    [result setScore:0.0];
    
    if ([points count] == 0) {
        return result;
    }
    
    points = [[self class] resample:points numPoints:DollarPNumPoints];
    points = [[self class] scale:points];
    points = [[self class] translate:points to:[DollarPoint origin]];
    
    float b = +INFINITY;
    int u = -1;
    
    for (int i = 0; i < [[self pointClouds] count]; i++) {
        float d = [[self class] greedyCloudMatch:points
                                        template:[[self pointClouds][i] points]];
        if (d < b) {
            b = d;
            u = i;
        }
    }
    
    if (u != -1) {
        [result setName:[[self pointClouds][u] name]];
        [result setScore:MAX((b - 2.0f) / -2.0f, 0.0f)];
    }
    
    return result;
}

- (void)setPointClouds:(NSMutableArray *)somePointClouds {
    pointClouds = [somePointClouds mutableCopy];
}

- (void)addGesture:(NSString *)name
            points:(NSArray *)points {
    DollarPointCloud *pointCloud = [[DollarPointCloud alloc] initWithName:name
                                                                   points:points];
    [[self pointClouds] addObject:pointCloud];
}

+ (float)greedyCloudMatch:(NSArray *)points
                 template:(NSArray *)template {
    float e = 0.50f;
	float step = floor(pow([points count], 1 - e));
	float min = +INFINITY;
    
	for (int i = 0; i < [points count]; i += step) {
		float d1 = [self cloudDistanceFrom:points to:template start:i];
		float d2 = [self cloudDistanceFrom:template to:points start:i];
		min = MIN(min, MIN(d1, d2));
	}
    
	return min;
}

+ (float)cloudDistanceFrom:(NSArray *)points1
                        to:(NSArray *)points2
                     start:(int)start {
    int numPoints1 = [points1 count];
    int numPoints2 = [points2 count];
    
    NSMutableArray *matched = [NSMutableArray arrayWithCapacity:numPoints1];
	for (int k = 0; k < numPoints1; k++) {
		matched[k] = @NO;
    }
    
	float sum = 0.0f;
	int i = start;
    
	do {
		int index = -1;
		float min = +INFINITY;
        
		for (int j = 0; j < [matched count]; j++) {
			if (![matched[j] boolValue]) {
                if (i < numPoints1 && j < numPoints2) {
                    float d = [self distanceFrom:points1[i] to:points2[j]];
                    if (d < min) {
                        min = d;
                        index = j;
                    }
                }
			}
		}

        if (index > -1) {
            matched[index] = @YES;
        }
        
		float weight = 1 - ((i - start + numPoints1) % numPoints1) / numPoints1;
		sum += weight * min;
		i = (i + 1) % numPoints1;
        
	} while (i != start);
    
	return sum;
}

+ (NSArray *)resample:(NSArray *)points
            numPoints:(int)numPoints {
    float I = [self pathLength:points] / (numPoints - 1);
	float D = 0.0f;
    
    NSMutableArray *thePoints = [points mutableCopy];
	NSMutableArray *newPoints = [NSMutableArray arrayWithObject:thePoints[0]];

	for (int i = 1; i < [thePoints count]; i++) {
        DollarPoint *prevPoint = thePoints[i - 1];
        DollarPoint *thisPoint = thePoints[i];

		if ([thisPoint id] == [prevPoint id]) {
			float d = [self distanceFrom:prevPoint to:thisPoint];
            
			if ((D + d) >= I) {
				float qx = [prevPoint x] + ((I - D) / d) * ([thisPoint x] - [prevPoint x]);
				float qy = [prevPoint y] + ((I - D) / d) * ([thisPoint y] - [prevPoint y]);
                
				DollarPoint *q = [[DollarPoint alloc] initWithId:[thisPoint id] x:qx y:qy];
                
				[newPoints addObject:q];
				[thePoints insertObject:q atIndex:i];
				D = 0.0f;
			} else {
                D += d;
            }
		}
	}
    
	if ([newPoints count] == numPoints - 1) {
        DollarPoint *lastPoint = thePoints[[thePoints count] - 1];
		[newPoints addObject:[lastPoint copy]];
    }
    
	return newPoints;
}

+ (NSArray *)scale:(NSArray *)points {
    float minX = +INFINITY;
    float maxX = -INFINITY;
    float minY = +INFINITY;
    float maxY = -INFINITY;
    
    DollarPoint *thisPoint;
	for (int i = 0; i < [points count]; i++) {
        thisPoint = points[i];
		minX = MIN(minX, [thisPoint x]);
		minY = MIN(minY, [thisPoint y]);
		maxX = MAX(maxX, [thisPoint x]);
		maxY = MAX(maxY, [thisPoint y]);
	}
    
	float size = MAX(maxX - minX, maxY - minY);
	NSMutableArray *newPoints = [NSMutableArray array];
    
	for (int i = 0; i < [points count]; i++) {
        thisPoint = points[i];
        
		float qx = ([thisPoint x] - minX) / size;
		float qy = ([thisPoint y] - minY) / size;
        
        DollarPoint *q = [[DollarPoint alloc] initWithId:[thisPoint id] x:qx y:qy];
        
        [newPoints addObject:q];
	}
    
	return newPoints;
}

+ (NSArray *)translate:(NSArray *)points
                    to:(DollarPoint *)point {
    DollarPoint *c = [[self class] centroid:points];
	NSMutableArray *newPoints = [NSMutableArray array];
    
	for (int i = 0; i < [points count]; i++) {
        DollarPoint *thisPoint = points[i];
        
		float qx = [thisPoint x] + [point x] - [c x];
		float qy = [thisPoint y] + [point y] - [c y];
        
        DollarPoint *q = [[DollarPoint alloc] initWithId:[thisPoint id] x:qx y:qy];
        
        [newPoints addObject:q];
	}
    
	return newPoints;
}

+ (DollarPoint *)centroid:(NSArray *)points {
    float x = 0.0f;
    float y = 0.0f;
    
	for (int i = 0; i < [points count]; i++) {
        DollarPoint *thisPoint = points[i];
        
		x += [thisPoint x];
		y += [thisPoint y];
	}
    
	x /= [points count];
	y /= [points count];
    
    return [[DollarPoint alloc] initWithId:0 x:x y:y];
}

+ (float)pathDistanceFrom:(NSArray *)points1
                       to:(NSArray *)points2 {
    float d = 0.0f;
    
	for (int i = 0; i < [points1 count]; i++) {
		d += [self distanceFrom:points1[i] to:points2[i]];
    }
    
	return d / [points1 count];
}

+ (float)pathLength:(NSArray *)points {
	float d = 0.0f;
    
	for (int i = 1; i < [points count]; i++) {
        DollarPoint *prevPoint = points[i - 1];
        DollarPoint *thisPoint = points[i];
        
		if ([thisPoint id] == [prevPoint id]) {
			d += [self distanceFrom:prevPoint to:thisPoint];
        }
	}
    
	return d;
}

+ (float)distanceFrom:(DollarPoint *)point1
                   to:(DollarPoint *)point2 {
    float dx = [point2 x] - [point1 x];
    float dy = [point2 y] - [point1 y];
    
    return sqrt(dx * dx + dy * dy);
}

@end