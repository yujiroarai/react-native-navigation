//
//  RNNAnimationController.m
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 18/08/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "RNNAnimationController.h"
#import "RNNSharedElementView.h"
#import "RNNInteractivePopController.h"

@interface  RNNAnimationController()
@property (nonatomic, strong)NSArray* transitions;
@property (nonatomic)double duration;
@property (nonatomic)double springDamping;
@property (nonatomic, strong) RNNInteractivePopController* interactivePopController;

@end

@implementation RNNAnimationController

-(void)setupTransition:(NSDictionary*)data{
	if ([data objectForKey:@"transitions"]) {
		self.transitions= [data objectForKey:@"transitions"];
	} else {
		[[NSException exceptionWithName:NSInvalidArgumentException reason:@"No transitions" userInfo:nil] raise];
	}
	if ([data objectForKey:@"duration"]) {
		self.duration = [[data objectForKey:@"duration"] doubleValue];
	} else {
		self.duration = 0.7;
	}
	if ([data objectForKey:@"springDamping"]) {
		self.springDamping = [[data objectForKey:@"springDamping"] doubleValue];
	} else {
		self.springDamping = 0.85;
	}
}

-(NSArray*)findRNNSharedElementViews:(UIView*)view{
	NSMutableArray* sharedElementViews = [NSMutableArray new];
	for(UIView *aView in view.subviews){
		if([aView isMemberOfClass:[RNNSharedElementView class]]){
			[sharedElementViews addObject:aView];
		} else{
			if ([aView subviews]) {
				[sharedElementViews addObjectsFromArray:[self findRNNSharedElementViews:aView]];
			}
		}
	}
	return sharedElementViews;
}

-(RNNSharedElementView*)findViewToShare:(NSArray*)RNNSharedElementViews withId:(NSString*)elementId{
	for (RNNSharedElementView* sharedView in RNNSharedElementViews) {
		if ([sharedView.elementId isEqualToString:elementId]){
			return sharedView;
		}
	}
	[[NSException exceptionWithName:NSInvalidArgumentException reason:@"elementId does not exist" userInfo:nil] raise];
	return nil;
}

-(NSArray*)prepareSharedElementTransition:(NSArray*)RNNSharedElementViews
			withContainerView:(UIView*)containerView
{
	NSMutableArray* sharedElementsData = [NSMutableArray new];
	for (NSDictionary* transition in self.transitions) {
		if ([transition[@"type"] isEqualToString:@"sharedElement"]){
			RNNSharedElementView* fromElement = [self findViewToShare:RNNSharedElementViews withId:transition[@"fromId"]];
			RNNSharedElementView* toElement = [self findViewToShare:RNNSharedElementViews withId:transition[@"toId"]];
			CGRect originFrame = [self frameFromSuperView:[fromElement subviews][0]];
			UIView* animationView = [[fromElement subviews][0] snapshotViewAfterScreenUpdates:NO];
			animationView.contentMode = UIViewContentModeScaleAspectFit;
			animationView.frame = originFrame;
			animationView.clipsToBounds = true;
			[containerView  addSubview:animationView];
			[fromElement setHidden: YES];
			[toElement setHidden: YES];
			[containerView bringSubviewToFront:animationView];
			CGRect toFrame = [self frameFromSuperView:[toElement subviews][0]];
			NSNumber* interactivePop = @(0);
			if ([transition objectForKey:@"interactivePop"]) {
				interactivePop = [transition objectForKey:@"interactivePop"];
			} 
			NSDictionary* sharedElementData = @{@"animationView" : animationView ,
												@"toFrame" : [NSValue valueWithCGRect:toFrame],
												@"fromView" : fromElement,
												@"toView" : toElement,
												@"interactivePop": interactivePop};
			[sharedElementsData addObject:sharedElementData];
		}
	}
    return sharedElementsData;
}

-(CGRect)frameFromSuperView:(UIView*)view{
	CGPoint sharedViewFrameOrigin = [view.superview convertPoint:view.frame.origin toView:nil];
	CGRect originRect = CGRectMake(sharedViewFrameOrigin.x, sharedViewFrameOrigin.y, view.frame.size.width, view.frame.size.height);
	return originRect;
}



- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
	
	UIViewController* toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIViewController* fromVC  = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIView* containerView = [transitionContext containerView];
	
	toVC.view.frame = fromVC.view.frame;
	//create transition image
	UIView* fromSnapshot = [fromVC.view snapshotViewAfterScreenUpdates:true];
	fromSnapshot.frame = fromVC.view.frame;
	[containerView addSubview:fromSnapshot];
	
	
	// 6: Create to screen snapshot
	UIView* toSnapshot = [toVC.view snapshotViewAfterScreenUpdates:true];
	toSnapshot.frame = fromVC.view.frame;
	[containerView addSubview:toSnapshot];
	toSnapshot.alpha = 0;
    NSArray* fromRNNSharedElementViews = [self findRNNSharedElementViews:fromVC.view];
	NSArray* toRNNSharedElementViews = [self findRNNSharedElementViews:toVC.view];
	NSArray* RNNSharedElementViews = [toRNNSharedElementViews arrayByAddingObjectsFromArray:fromRNNSharedElementViews];
	NSArray* viewsToAnimate = [self prepareSharedElementTransition:RNNSharedElementViews withContainerView:containerView];

	[UIView animateWithDuration:[self transitionDuration:transitionContext ] delay:0 usingSpringWithDamping:self.springDamping initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut  animations:^{
		toSnapshot.alpha = 1;
		for (NSMutableDictionary* viewData in viewsToAnimate ) {
			UIView* animtedView = viewData[@"animationView"];
			animtedView.frame = [viewData[@"toFrame"] CGRectValue];
		}
	} completion:^(BOOL finished) {
		// 9: Remove transition views
		for (NSMutableDictionary* viewData in viewsToAnimate ) {
			[viewData[@"fromView"] setHidden:NO];
			[viewData[@"toView"] setHidden:NO];
			UIView* animtedView = viewData[@"animationView"];
			[animtedView removeFromSuperview];
			//pass ViewController to interactivePopElement
			if ([viewData[@"interactivePop"] boolValue]) {
				
				self.interactivePopController = [[RNNInteractivePopController alloc] initWithTopView:viewData[@"toView"] andBottomView:viewData[@"fromView"] andViewController:toVC];
					UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopController
																							  action:@selector(handleGesture:)];
					[viewData[@"toView"] addGestureRecognizer:gesture];
				
			}
		}
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



