//
//  RNNSharedElementView.m
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 29/08/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import "RNNSharedElementView.h"

@implementation RNNSharedElementView

//- (instancetype)init
//{
//	self = [super init];
//	if (self) {
//		
//		
//		
//		
//	}
//	return self;
//}
//
//- (UIView *)rootView {
//	UIView *view = self;
//	while (view.superview != Nil) {
//		view = view.superview;
//	}
//	return view;
//}

//-(void)handleGesture:(UIPanGestureRecognizer*)recognizer {
//	if (self.interactive) {
//	CGPoint translation = [recognizer translationInView:self.superview];
////	[[self.window.subviews objectAtIndex:0] viewController]
//		if (recognizer.state == UIGestureRecognizerStateBegan) {
//			self.originalCenter = [[recognizer view] center];
//			self.window.rootViewController.navigationController.delegate = self.interactiveController;
//			[self.window.rootViewController.navigationController popViewControllerAnimated:YES];
//		} else if (recognizer.state == UIGestureRecognizerStateChanged) {
//			recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
//												 recognizer.view.center.y + translation.y);
//			[recognizer setTranslation:CGPointMake(0, 0) inView:self.superview];
//		} else if (recognizer.state == UIGestureRecognizerStateEnded) {
//			CGPoint velocity = [recognizer velocityInView:recognizer.view];
//			if (translation.y > 20 || velocity.x > 0) {
//				[self.superview.inputViewController.navigationController popViewControllerAnimated:YES];
//			} else {
//				[UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut  animations:^{
//					recognizer.view.center = self.originalCenter;
//																		} completion:^(BOOL finished) {
//					
//				}];
//			}
//		}
//	}
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
