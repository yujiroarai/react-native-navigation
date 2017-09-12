#import <UIKit/UIKit.h>
#import "RNNSharedElementView.h"

@interface RNNInteractivePopController : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) RNNSharedElementView* topView;
@property (nonatomic, strong) RNNSharedElementView* bottomView;
@property (nonatomic, strong) UIViewController* vc;
@property (nonatomic) CGRect originFrame;
@property CGPoint toCenter;

-(instancetype)initWithTopView:(RNNSharedElementView*)topView andBottomView:(RNNSharedElementView*)bottomView andOriginFrame:(CGRect)originFrame andViewController:(UIViewController*)vc;
-(void)handleGesture:(UIPanGestureRecognizer*)recognizer;

@end
