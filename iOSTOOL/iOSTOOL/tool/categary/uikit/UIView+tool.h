

#import <UIKit/UIKit.h>

@interface UIView (tool)

#pragma mark [frame]

/**
*  view的x(横)坐标
*/
@property (nonatomic, assign)CGFloat x;
/**
 *  view的y(纵)坐标
 */
@property (nonatomic, assign)CGFloat y;
/**
 *  view的宽度
 */
@property (nonatomic, assign)CGFloat width;
/**
 *  view的高度
 */
@property (nonatomic, assign)CGFloat height;
/**
 *  view的中心横坐标
 */
@property (nonatomic, assign)CGFloat centerX;
/**
 *  view的中心纵坐标
 */
@property (nonatomic, assign)CGFloat centerY;

- (void) moveBy: (CGPoint) delta;
- (void) scaleBy: (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;
@end
