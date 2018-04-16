#import <QuartzCore/QuartzCore.h>

enum {
    AUISelectiveBordersFlagLeft = 1 <<  0,
    AUISelectiveBordersFlagRight = 1 <<  1, 
    AUISelectiveBordersFlagTop = 1 <<  2, 
    AUISelectiveBordersFlagBottom = 1 <<  3
};
typedef NSUInteger AUISelectiveBordersFlag;


@interface AUISelectiveBordersLayer : CALayer {
    CAShapeLayer *borderLayer;
}

@property (nonatomic, strong) UIColor *selectiveBordersColor;
@property (nonatomic) float selectiveBordersWidth;
@property (nonatomic) AUISelectiveBordersFlag selectiveBorderFlag;

@end
