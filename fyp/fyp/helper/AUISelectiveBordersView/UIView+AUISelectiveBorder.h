#import <UIKit/UIKit.h>
#import "AUISelectiveBordersLayer.h"

@interface UIView (AUISelectiveBorder)

@property (nonatomic, strong) UIColor *selectiveBordersColor;
@property (nonatomic) float selectiveBordersWidth;
@property (nonatomic) AUISelectiveBordersFlag selectiveBorderFlag;

@end
