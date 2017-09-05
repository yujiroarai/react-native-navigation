//
//  RNNInteractivePopController.h
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 03/09/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNNSharedElementView.h"

@interface RNNInteractivePopController : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) RNNSharedElementView* topView;
@property (nonatomic, strong) RNNSharedElementView* bottomView;
@property (nonatomic, strong) UIViewController* vc;
@property CGPoint toCenter;

-(instancetype)initWithTopView:(RNNSharedElementView*)topView andBottomView:(RNNSharedElementView*)bottomView andViewController:(UIViewController*)vc;
-(void)handleGesture:(UIPanGestureRecognizer*)recognizer;

@end
