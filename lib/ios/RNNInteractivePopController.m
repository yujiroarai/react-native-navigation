//
//  RNNInteractivePopController.m
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 03/09/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "RNNInteractivePopController.h"
#import "RNNSharedElementView.h"

@interface  RNNInteractivePopController()
@property (nonatomic) CGPoint originalCenter;
@property (nonatomic) CGFloat percent;
@property (nonatomic) UINavigationController* nc;
@property (nonatomic) UIView* imageSnapshot;

@end

@implementation RNNInteractivePopController

-(instancetype)initWithTopView:(RNNSharedElementView*)topView andBottomView:(RNNSharedElementView*)bottomView andViewController:(UIViewController*)vc{
	RNNInteractivePopController* interactiveController = [[RNNInteractivePopController alloc] init];
	[interactiveController setTopView:topView];
	[interactiveController setBottomView:bottomView];
	[interactiveController setVc:vc];
	[interactiveController setNc:vc.navigationController];
	
	return interactiveController;
}

-(void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
	[super startInteractiveTransition:transitionContext];
}
-(void)handleGesture:(UIPanGestureRecognizer*)recognizer {
	
	CGPoint translation = [recognizer translationInView:self.topView];
	
	NSLog(@"&&&&&&&&&&&& %@", NSStringFromCGPoint(translation));
		if (recognizer.state == UIGestureRecognizerStateBegan) {
			self.originalCenter = [[recognizer view] center];
			NSLog(@"**************** %@", self.nc);
			self.nc.delegate = self;
			
			[self.nc popViewControllerAnimated:YES];
		} else if (recognizer.state == UIGestureRecognizerStateChanged) {
//			self.topView.center = CGPointMake(recognizer.view.center.x + translation.x,
//											  recognizer.view.center.y + translation.y);
			[self animateAlongsideTransition:^void(id context){
					self.imageSnapshot.center = CGPointMake(self.imageSnapshot.center.x + translation.x,
													  self.imageSnapshot.center.y + translation.y);
				}
											completion:nil];
			[recognizer setTranslation:CGPointMake(0, 0) inView:self.imageSnapshot];
//			[self updateInteractiveTransition:0.8];
			NSLog(@"***********  %@", NSStringFromCGPoint(translation));
//			NSLog(@"***********  %@", NSStringFromCGPoint(self.topView.center));
//			NSLog(@"***********  %@", NSStringFromCGPoint(CGPointMake(recognizer.view.center.x + translation.x,
//																	  recognizer.view.center.y + translation.y)));
//			NSLog(@"***********  %@", NSStringFromCGPoint(CGPointMake(
//																	  translation.x,
//																	 translation.y)));
			

//			recognizer.view.center =
			
			
		} else if (recognizer.state == UIGestureRecognizerStateEnded) {
			
			[UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut  animations:^{
									recognizer.view.center = self.originalCenter;
								} completion:^(BOOL finished) {
									self.nc.delegate = nil;
									NSLog(@"**************** %@", self.nc);
								}];
			NSLog(@"**************** %@", self.nc);
			[self finishInteractiveTransition];
			//			[self finishInteractiveTransition];
//			CGPoint velocity = [recognizer velocityInView:recognizer.view];
//			if (translation.y > 20 || velocity.x > 0) {
//				
//			} else {
//
//			}
		
	}
}
- (BOOL)animateAlongsideTransition:(void (^)(id<UIViewControllerTransitionCoordinatorContext> context))animation
							  completion:(void (^)(id<UIViewControllerTransitionCoordinatorContext> context))completion;{
	animation(nil);
	return YES;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	
	UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIViewController* fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIView* containerView = [transitionContext containerView];
	
	toVC.view.frame = fromVC.view.frame;
	UIView* imageSnapshot = [self.topView snapshotViewAfterScreenUpdates:false];
	CGPoint sharedViewFrameOrigin = [self.topView.superview convertPoint:self.topView.frame.origin toView:nil];
	CGRect originRect = CGRectMake(sharedViewFrameOrigin.x, sharedViewFrameOrigin.y, self.topView.frame.size.width, self.topView.frame.size.height);

	fromVC.view.alpha = 0.3;
	self.topView.alpha = 1;
	
	self.imageSnapshot = imageSnapshot;
	self.imageSnapshot.frame = originRect;
	//create transition image
//	UIView* fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:true];
//	fromSnapshot.frame = fromVC.view.frame;
//	[containerView addSubview:fromSnapshot];
//	UIView* topViewSnapshot = [self.topView snapshotViewAfterScreenUpdates:true];
	
	// 6: Create to screen snapshot
	
//	[containerView addSubview:topViewSnapshot];
	[self.bottomView setHidden:YES];
	
	UIView* toSnapshot = [toVC.view snapshotViewAfterScreenUpdates:true];
	toSnapshot.frame = fromVC.view.frame;
	[containerView insertSubview:(UIView *)toSnapshot atIndex:1];
	[containerView addSubview:self.imageSnapshot];
	toSnapshot.alpha = 0.3;
//	[UIView animateKeyframesWithDuration:(NSTimeInterval)[self transitionDuration:transitionContext]
//							delay:0
//								 options: UIViewKeyframeAnimationOptionAllowUserInteraction
//							  animations:^{
//								  [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
//									  imageView.center = CGPointMake(imageView.center.x, [obj floatValue]);
//								  }];
//							  }
//							  completion:^(BOOL finished) {
//								  //		[fromSnapshot removeFromSuperview];
//								  //		[toSnapshot removeFromSuperview];
//								  [self.bottomView setHidden:NO];
//								  // 10: Complete transition
//								  if (![transitionContext transitionWasCancelled]) {
//									  [containerView addSubview: toVC.view];
//									  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//								  }
//							  }];
	[self.topView setHidden:YES];
	[UIView animateWithDuration:[self transitionDuration:transitionContext ] delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut  animations:^{
//		toSnapshot.alpha = 1;
		fromVC.view.alpha = 0;
		self.topView.alpha = 1;
//		topViewSnapshot.center = self.toCenter;
	} completion:^(BOOL finished) {
//		[fromSnapshot removeFromSuperview];
//		[toSnapshot removeFromSuperview];
		[self.bottomView setHidden:NO];
		[self.imageSnapshot removeFromSuperview];
		[toSnapshot removeFromSuperview];
		// 10: Complete transition
		if (![transitionContext transitionWasCancelled]) {
			[containerView addSubview: toVC.view];
			[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
		}
	}];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								  animationControllerForOperation:(UINavigationControllerOperation)operation
											   fromViewController:(UIViewController*)fromVC
												 toViewController:(UIViewController*)toVC {
	{
		if (operation == UINavigationControllerOperationPop) {
			return self;
		} else {
			return nil;
		}
	}
	return nil;
	
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
						 interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
	return self;
}

@end
