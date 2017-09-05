#import "RNNNavigationStackManager.h"
#import "RNNRootViewController.h"
#import "RCCSyncRootView.h"
#import "React/RCTShadowView.h"
#import "React/RCTUIManager.h"
#import "RNNAnimationController.h"


dispatch_queue_t RCTGetUIManagerQueue(void);
@implementation RNNNavigationStackManager {
	RNNStore *_store;
}

-(instancetype)initWithStore:(RNNStore*)store {
	self = [super init];
	_store = store;
	return self;
}

-(void)pushAfterLoad:(NSDictionary*)notif {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RCTContentDidAppearNotification" object:nil];
	[[self.fromVC navigationController] pushViewController:self.toVC animated:YES];
	self.fromVC.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

-(void)customPush:(UIViewController *)newTop onTop:(NSString *)containerId customAnimationData:(NSDictionary*)customAnimationData bridge:(RCTBridge*)bridge {
	UIViewController *vc = [_store findContainerForId:containerId];
	RNNRootViewController* newTopRootView = (RNNRootViewController*)newTop;
	self.fromVC = vc;
	self.toVC = newTopRootView;
	vc.navigationController.delegate = newTopRootView;
//	[newTopRootView.interactiveAnimator wireToViewController:(UIViewController*)vc withCustomAnimationData:(NSDictionary*)customAnimationData];
	[newTopRootView.animator setupTransition:customAnimationData];
	RCTUIManager *uiManager = bridge.uiManager;
	CGRect screenBound = [[UIScreen mainScreen] bounds];
	CGSize screenSize = screenBound.size;
	[uiManager setAvailableSize:screenSize forRootView:self.toVC.view];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(pushAfterLoad:)
												 name: @"RCTContentDidAppearNotification"
											   object:nil];
}

-(void)push:(UIViewController *)newTop onTop:(NSString *)containerId {
	UIViewController *vc = [_store findContainerForId:containerId];
	[[vc navigationController] pushViewController:newTop animated:YES];
}

-(void)customPop:(NSString *)containerId withAnimationData:(NSDictionary *)animationData{
	UIViewController* vc = [_store findContainerForId:containerId];
	UINavigationController* nvc = [vc navigationController];
	if ([nvc topViewController] == vc) {
		RNNRootViewController* RNNVC = (RNNRootViewController*)vc;
		nvc.delegate = RNNVC;
		[RNNVC.animator setupTransition:animationData];
		[nvc popViewControllerAnimated:YES];
	} else {
		NSMutableArray * vcs = nvc.viewControllers.mutableCopy;
		[vcs removeObject:vc];
		[nvc setViewControllers:vcs animated:YES];
	}
	[_store removeContainer:containerId];
}

-(void)pop:(NSString *)containerId {
	UIViewController* vc = [_store findContainerForId:containerId];
	UINavigationController* nvc = [vc navigationController];
	if ([nvc topViewController] == vc) {
		[nvc popViewControllerAnimated:YES];
	} else {
		NSMutableArray * vcs = nvc.viewControllers.mutableCopy;
		[vcs removeObject:vc];
		[nvc setViewControllers:vcs animated:YES];
	}
	[_store removeContainer:containerId];
}

-(void)popTo:(NSString*)containerId {
	UIViewController *vc = [_store findContainerForId:containerId];
	
	if (vc) {
		UINavigationController *nvc = [vc navigationController];
		if(nvc) {
			NSArray *poppedVCs = [nvc popToViewController:vc animated:YES];
			[self removePopedViewControllers:poppedVCs];
		}
	}
}

-(void) popToRoot:(NSString*)containerId {
	UIViewController* vc = [_store findContainerForId:containerId];
	UINavigationController* nvc = [vc navigationController];
	NSArray* poppedVCs = [nvc popToRootViewControllerAnimated:YES];
	[self removePopedViewControllers:poppedVCs];
}

-(void)removePopedViewControllers:(NSArray*)viewControllers {
	for (UIViewController *popedVC in viewControllers) {
		[_store removeContainerByViewControllerInstance:popedVC];
	}
}

@end
