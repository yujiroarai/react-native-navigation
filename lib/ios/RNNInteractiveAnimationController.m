////
////  RNNInteractiveAnimationController.m
////  ReactNativeNavigation
////
////  Created by Elad Bogomolny on 31/08/2017.
////  Copyright © 2017 Wix. All rights reserved.
////
//
//#import "RNNInteractiveAnimationController.h"
//#import "RNNRootViewController.h"
//
//@interface RNNInteractiveAnimationController()
//
//@property (nonatomic, strong)NSNumber* shouldCompleteTransition;
//@property (nonatomic, weak)UIView* view;
//@property (nonatomic, weak)UIViewController* viewController;
//
//@end
//
//@implementation RNNInteractiveAnimationController
//
////-(void)updateInteractiveTransition:(CGFloat)percentComplete{
////	
////}
////
////-(void)finishInteractiveTransition{
////	
////}
////
////-(void)cancelInteractiveTransition{
////	
////}
//
//-(void)handleGesture:(UIPanGestureRecognizer*)gesture {
//	CGPoint translation = [gesture translationInView:[[gesture view] superview]];
//	CGFloat progress = (translation.x / 200);
//	progress = MIN(MAX(progress, 0.0), 1.0);
//	switch ([gesture state]) {
//	 case UIGestureRecognizerStateBegan:
//			// 2
//			self.interactionInProgress = @(1);
//			[self.viewController dismissViewControllerAnimated:true completion: nil];
//			break;
//	case UIGestureRecognizerStateChanged:
//			// 3
//			self.shouldCompleteTransition = @(progress > 0.5);
//			[self updateInteractiveTransition:progress];
//			break;
//			
//	case UIGestureRecognizerStateCancelled:
//			// 4
//			self.interactionInProgress = @(0);
//			[self cancelInteractiveTransition];
//			break;
//	case UIGestureRecognizerStateEnded:
//			// 5
//			self.interactionInProgress = @(0);
//			
//			if (![self shouldCompleteTransition]) {
//				[self cancelInteractiveTransition];
//			} else {
//				[self finishInteractiveTransition];
//			}
//			break;
//			
//    default:
//			NSLog(@"**********##*#**** UNSUPPORTED");
//			break;
//	}
//
//	
// }
//
//-(void)wireToViewController:(RNNRootViewController*)viewController withCustomAnimationData:(NSDictionary*)customAnimationData{
//	NSString* viewToDragId = customAnimationData[@"interactive"][@"view"];
//	NSArray* viewsToShare = [viewController.animator findRNNSharedElementViews:viewController.view];
//	UIView* view = [viewController.animator findViewToShare:viewsToShare withId:viewToDragId];
//	self.view = view;
//	self.viewController = viewController;
//	UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
//																						action:@selector(handleGesture:)];
//	
//	[view addGestureRecognizer:gesture];
//}
//
//@end
