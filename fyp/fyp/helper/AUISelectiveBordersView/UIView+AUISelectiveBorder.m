#import "UIView+AUISelectiveBorder.h"

@implementation UIView (AUISelectiveBorder)

+(Class) layerClass {
    return [AUISelectiveBordersLayer class];
}

-(AUISelectiveBordersFlag) selectiveBorderFlag
{
    AUISelectiveBordersLayer *selectiveLayer = (AUISelectiveBordersLayer *)self.layer;
    return selectiveLayer.selectiveBorderFlag;
}

-(void) setSelectiveBorderFlag:(AUISelectiveBordersFlag)selectiveBorderFlag
{
    AUISelectiveBordersLayer *selectiveLayer = (AUISelectiveBordersLayer *)self.layer;
    selectiveLayer.selectiveBorderFlag = selectiveBorderFlag;
}

-(UIColor *)selectiveBordersColor
{
    AUISelectiveBordersLayer *selectiveLayer = (AUISelectiveBordersLayer *)self.layer;
    return selectiveLayer.selectiveBordersColor;
}

-(void) setSelectiveBordersColor:(UIColor *)selectiveBordersColor
{
    AUISelectiveBordersLayer *selectiveLayer = (AUISelectiveBordersLayer *)self.layer;
    selectiveLayer.selectiveBordersColor = selectiveBordersColor;
}

-(float) selectiveBordersWidth
{
    AUISelectiveBordersLayer *selectiveLayer = (AUISelectiveBordersLayer *)self.layer;
    return selectiveLayer.selectiveBordersWidth;
}

-(void) setSelectiveBordersWidth:(float)selectiveBordersWidth
{
    AUISelectiveBordersLayer *selectiveLayer = (AUISelectiveBordersLayer *)self.layer;
    selectiveLayer.selectiveBordersWidth = selectiveBordersWidth;
}

@end
