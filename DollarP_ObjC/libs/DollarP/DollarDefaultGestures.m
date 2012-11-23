#import "DollarDefaultGestures.h"
#import "DollarPointCloud.h"
#import "DollarPoint.h"

DollarPointCloud * MakePointCloud(NSString *name, NSArray *points) {
    return [[DollarPointCloud alloc] initWithName:name points:points];
}

DollarPoint * MakePoint(float x, float y, int id) {
    return [[DollarPoint alloc] initWithId:@(id) x:x y:y];
}

@implementation DollarDefaultGestures

+ (id)defaultPointClouds {
    static NSArray *defaultPointClouds = nil;
    if (!defaultPointClouds) {
        defaultPointClouds = [self pointClouds];
    }
    return defaultPointClouds;
}

+ (NSMutableArray *)pointClouds {
    NSMutableArray *pointClouds = [NSMutableArray array];
    
	pointClouds[0] = MakePointCloud(@"T", @[
                                    MakePoint(30,7,1),
                                    MakePoint(103,7,1),
                      
                                    MakePoint(66,7,2),
                                    MakePoint(66,87,2)
                                    ]);
    
	pointClouds[1] = MakePointCloud(@"N", @[
                                    MakePoint(177,92,1),
                                    MakePoint(177,2,1),
                      
                                    MakePoint(182,1,2),
                                    MakePoint(246,95,2),
                      
                                    MakePoint(247,87,3),
                                    MakePoint(247,1,3)
                                    ]);
    
	pointClouds[2] = MakePointCloud(@"D", @[
                                    MakePoint(345,9,1),
                                    MakePoint(345,87,1),
                      
                                    MakePoint(351,8,2),
                                    MakePoint(363,8,2),
                                    MakePoint(372,9,2),
                                    MakePoint(380,11,2),
                                    MakePoint(386,14,2),
                                    MakePoint(391,17,2),
                                    MakePoint(394,22,2),
                                    MakePoint(397,28,2),
                                    MakePoint(399,34,2),
                                    MakePoint(400,42,2),
                                    MakePoint(400,50,2),
                                    MakePoint(400,56,2),
                                    MakePoint(399,61,2),
                                    MakePoint(397,66,2),
                                    MakePoint(394,70,2),
                                    MakePoint(391,74,2),
                                    MakePoint(386,78,2),
                                    MakePoint(382,81,2),
                                    MakePoint(377,83,2),
                                    MakePoint(372,85,2),
                                    MakePoint(367,87,2),
                                    MakePoint(360,87,2),
                                    MakePoint(355,88,2),
                                    MakePoint(349,87,2)
                                    ]);
    
	pointClouds[3] = MakePointCloud(@"P", @[
                                    MakePoint(507,8,1),
                                    MakePoint(507,87,1),
                                    
                                    MakePoint(513,7,2),
                                    MakePoint(528,7,2),
                                    MakePoint(537,8,2),
                                    MakePoint(544,10,2),
                                    MakePoint(550,12,2),
                                    MakePoint(555,15,2),
                                    MakePoint(558,18,2),
                                    MakePoint(560,22,2),
                                    MakePoint(561,27,2),
                                    MakePoint(562,33,2),
                                    MakePoint(561,37,2),
                                    MakePoint(559,42,2),
                                    MakePoint(556,45,2),
                                    MakePoint(550,48,2),
                                    MakePoint(544,51,2),
                                    MakePoint(538,53,2),
                                    MakePoint(532,54,2),
                                    MakePoint(525,55,2),
                                    MakePoint(519,55,2),
                                    MakePoint(513,55,2),
                                    MakePoint(510,55,2)
                                    ]);
    
	pointClouds[4] = MakePointCloud(@"X", @[
                                    MakePoint(30,146,1),
                                    MakePoint(106,222,1),
                                    
                                    MakePoint(30,225,2),
                                    MakePoint(106,146,2)
                                    ]);
    
	pointClouds[5] = MakePointCloud(@"H", @[
                                    MakePoint(188,137,1),
                                    MakePoint(188,225,1),
                                    
                                    MakePoint(188,180,2),
                                    MakePoint(241,180,2),
                                    
                                    MakePoint(241,137,3),
                                    MakePoint(241,225,3)
                                    ]);
    
	pointClouds[6] = MakePointCloud(@"I", @[
                                    MakePoint(371,149,1),
                                    MakePoint(371,221,1),
                                    
                                    MakePoint(341,149,2),
                                    MakePoint(401,149,2),
                                    
                                    MakePoint(341,221,3),
                                    MakePoint(401,221,3)
                                    ]);
    
	pointClouds[7] = MakePointCloud(@"exclamation", @[
                                    MakePoint(526,142,1),
                                    MakePoint(526,204,1),
                                    
                                    MakePoint(526,221,2)
                                    ]);
    
	pointClouds[8] = MakePointCloud(@"line", @[
                                    MakePoint(12,347,1),
                                    MakePoint(119,347,1)
                                    ]);
    
	pointClouds[9] = MakePointCloud(@"five-point star", @[
                                    MakePoint(177,396,1),
                                    MakePoint(223,299,1),
                                    MakePoint(262,396,1),
                                    MakePoint(168,332,1),
                                    MakePoint(278,332,1),
                                    MakePoint(184,397,1)
                                    ]);
    
	pointClouds[10] = MakePointCloud(@"null", @[
                                     MakePoint(382,310,1),
                                     MakePoint(377,308,1),
                                     MakePoint(373,307,1),
                                     MakePoint(366,307,1),
                                     MakePoint(360,310,1),
                                     MakePoint(356,313,1),
                                     MakePoint(353,316,1),
                                     MakePoint(349,321,1),
                                     MakePoint(347,326,1),
                                     MakePoint(344,331,1),
                                     MakePoint(342,337,1),
                                     MakePoint(341,343,1),
                                     MakePoint(341,350,1),
                                     MakePoint(341,358,1),
                                     MakePoint(342,362,1),
                                     MakePoint(344,366,1),
                                     MakePoint(347,370,1),
                                     MakePoint(351,374,1),
                                     MakePoint(356,379,1),
                                     MakePoint(361,382,1),
                                     MakePoint(368,385,1),
                                     MakePoint(374,387,1),
                                     MakePoint(381,387,1),
                                     MakePoint(390,387,1),
                                     MakePoint(397,385,1),
                                     MakePoint(404,382,1),
                                     MakePoint(408,378,1),
                                     MakePoint(412,373,1),
                                     MakePoint(416,367,1),
                                     MakePoint(418,361,1),
                                     MakePoint(419,353,1),
                                     MakePoint(418,346,1),
                                     MakePoint(417,341,1),
                                     MakePoint(416,336,1),
                                     MakePoint(413,331,1),
                                     MakePoint(410,326,1),
                                     MakePoint(404,320,1),
                                     MakePoint(400,317,1),
                                     MakePoint(393,313,1),
                                     MakePoint(392,312,1),
                                     
                                     MakePoint(418,309,2),
                                     MakePoint(337,390,2)
                                    ]);
    
	pointClouds[11] = MakePointCloud(@"arrowhead", @[
                                     MakePoint(506,349,1),
                                     MakePoint(574,349,1),
                                     
                                     MakePoint(525,306,2),
                                     MakePoint(584,349,2),
                                     MakePoint(525,388,2)
                                     ]);
    
	pointClouds[12] = MakePointCloud(@"pitchfork", @[
                                     MakePoint(38,470,1),
                                     MakePoint(36,476,1),
                                     MakePoint(36,482,1),
                                     MakePoint(37,489,1),
                                     MakePoint(39,496,1),
                                     MakePoint(42,500,1),
                                     MakePoint(46,503,1),
                                     MakePoint(50,507,1),
                                     MakePoint(56,509,1),
                                     MakePoint(63,509,1),
                                     MakePoint(70,508,1),
                                     MakePoint(75,506,1),
                                     MakePoint(79,503,1),
                                     MakePoint(82,499,1),
                                     MakePoint(85,493,1),
                                     MakePoint(87,487,1),
                                     MakePoint(88,480,1),
                                     MakePoint(88,474,1),
                                     MakePoint(87,468,1),
                                     
                                     MakePoint(62,464,2),
                                     MakePoint(62,571,2)
                                    ]);
    
	pointClouds[13] = MakePointCloud(@"six-point star", @[
                                     MakePoint(177,554,1),
                                     MakePoint(223,476,1),
                                     MakePoint(268,554,1),
                                     MakePoint(183,554,1),
                                    
                                     MakePoint(177,490,2),
                                     MakePoint(223,568,2),
                                     MakePoint(268,490,2),
                                     MakePoint(183,490,2)
                                    ]);
    
	pointClouds[14] = MakePointCloud(@"asterisk", @[
                                     MakePoint(325,499,1),
                                     MakePoint(417,557,1),
                                     
                                     MakePoint(417,499,2),
                                     MakePoint(325,557,2),
                                     
                                     MakePoint(371,486,3),
                                     MakePoint(371,571,3)
                                    ]);
    
	pointClouds[15] = MakePointCloud(@"half-note", @[
                                     MakePoint(546,465,1),
                                     MakePoint(546,531,1),
                                     
                                     MakePoint(540,530,2),
                                     MakePoint(536,529,2),
                                     MakePoint(533,528,2),
                                     MakePoint(529,529,2),
                                     MakePoint(524,530,2),
                                     MakePoint(520,532,2),
                                     MakePoint(515,535,2),
                                     MakePoint(511,539,2),
                                     MakePoint(508,545,2),
                                     MakePoint(506,548,2),
                                     MakePoint(506,554,2),
                                     MakePoint(509,558,2),
                                     MakePoint(512,561,2),
                                     MakePoint(517,564,2),
                                     MakePoint(521,564,2),
                                     MakePoint(527,563,2),
                                     MakePoint(531,560,2),
                                     MakePoint(535,557,2),
                                     MakePoint(538,553,2),
                                     MakePoint(542,548,2),
                                     MakePoint(544,544,2),
                                     MakePoint(546,540,2),
                                     MakePoint(546,536,2)
                                    ]);
    
    return pointClouds;
}

@end