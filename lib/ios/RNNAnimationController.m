//
//  RNNAnimationController.m
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 18/08/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "RNNAnimationController.h"

@protocol ImageTransitionProtocol

-(void)transitionSetup;
-(void)transitionCleanup;
-(CGRect)imageWindowFrame;

@end

@interface  RNNAnimationController()

@property (nonatomic, strong)UIImage* image;
@property (nonatomic, strong)id<ImageTransitionProtocol> fromDelegate;
@property (nonatomic, strong)id<ImageTransitionProtocol> toDelegate;
@end

@implementation RNNAnimationController

-(void)setupImageTransition:(UIImage*)image andFromDelegate:(id<ImageTransitionProtocol>)fromDelegate andtoDelegate:(id<ImageTransitionProtocol>)toDelegate {
	self.image = image;
	self.fromDelegate = fromDelegate;
	self.toDelegate = toDelegate;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	
	UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIViewController* fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//	UIImage* testImage = [[[fromVC.view viewWithTag:5432333] subviews][0] subviews][0];
//	self setupImageTransition:fromVC andFromDelegate:<#(id<ImageTransitionProtocol>)#> andtoDelegate:<#(id<ImageTransitionProtocol>)#>
	self.image = [[[[fromVC.view viewWithTag:5432333] subviews][0] subviews][0] image];
	NSLog(@"*******************^&^&^&^ %@",[[[fromVC.view viewWithTag:5432333] subviews][0] subviews][0]);
	NSLog(@"*******************^&^&^&^ %@",[toVC.view viewWithTag:5432335]);

	UIView* containerView = [transitionContext containerView];
	toVC.view.frame = fromVC.view.frame;
	//create transition image
	UIImageView* imageView = [[UIImageView alloc] initWithImage:self.image];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
//	imageView.frame = (self.fromDelegate == nil) ? CGRectMake(0, 0, 0, 0) : [self.fromDelegate imageWindowFrame];
	imageView.frame = [fromVC.view viewWithTag:5432333].frame;
	imageView.clipsToBounds = true;
	[containerView  addSubview:imageView];
	// 5: Create from screen snapshot
	UIView* fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:true];
	fromSnapshot.frame = fromVC.view.frame;
	[containerView addSubview:fromSnapshot];
//	[self.fromDelegate transitionSetup];
	[[toVC.view viewWithTag:5432335] setHidden:YES];
	[[fromVC.view viewWithTag:5432333] setHidden: YES];
//	[self.toDelegate transitionSetup];
	// 6: Create to screen snapshot
	UIView* toSnapshot = [toVC.view snapshotViewAfterScreenUpdates:true];
	toSnapshot.frame = fromVC.view.frame;
	[containerView addSubview:toSnapshot];
	toSnapshot.alpha = 0;
	
	// 7: Bring the image view to the front and get the final frame
	[containerView bringSubviewToFront:imageView];
//	CGRect toFrame = (self.toDelegate == nil) ? CGRectMake(0, 0, 0, 0) : [self.toDelegate imageWindowFrame];
	CGRect toFrame = [toVC.view viewWithTag:5432335].frame;
	
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext ] delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut  animations:^{
		toSnapshot.alpha = 1;
		imageView.frame = toFrame;

	} completion:^(BOOL finished) {
		// 9: Remove transition views
//		[self.toDelegate transitionCleanup	];
//		[self.fromDelegate transitionCleanup];
		[[toVC.view viewWithTag:5432335] setHidden:NO];
		[[fromVC.view viewWithTag:5432333] setHidden: NO];
		[imageView removeFromSuperview];
		[fromSnapshot removeFromSuperview];
		[toSnapshot removeFromSuperview];
		
		// 10: Complete transition
		if (![transitionContext transitionWasCancelled]) {
			[containerView addSubview: toVC.view];
		[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
		}
	}];
}
@end



