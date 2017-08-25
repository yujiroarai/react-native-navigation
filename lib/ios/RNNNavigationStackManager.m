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
	[self.toVC view];
//	[self.fromVC navigationController] will
	RCTShadowView* Moshe = [[RCTShadowView alloc] init];
	NSMutableSet<RCTShadowView *> *viewsWithNewFrame = [NSMutableSet set];
	[Moshe applyLayoutNode:Moshe.yogaNode viewsWithNewFrame:viewsWithNewFrame absolutePosition:CGPointZero];
	
	
	NSLog(@"*******************^&^&^&^ %@",viewsWithNewFrame);
	[[self.fromVC navigationController] pushViewController:self.toVC animated:YES];
	NSLog(@"*******************^&^&^&^ %@",[self.fromVC.view viewWithTag:5432333]);
	NSLog(@"*******************^&^&^&^ %@",[self.toVC.view viewWithTag:5432335]);
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"RCTContentDidAppearNotification" object:nil];
}

-(void)push:(UIViewController *)newTop onTop:(NSString *)containerId bridge:(RCTBridge*)bridge {
	UIViewController *vc = [_store findContainerForId:containerId];
	self.fromVC = vc;
	RNNRootViewController* newTopRootView = (RNNRootViewController*)newTop;
	self.toVC = newTopRootView;
	vc.navigationController.delegate = newTopRootView;
	vc.navigationController.interactivePopGestureRecognizer.delegate = nil;
	if (newTopRootView.navigationOptions.customTransition) {
		RCTUIManager *uiManager = bridge.uiManager;
//		NSDictionary *props = @{@"name": @"Daniel", @"greeting": @"Hello World"};
//		__unused RCCSyncRootView *rootView = [[RCCSyncRootView alloc] initWithBridge:bridge moduleName:@"SyncExample" initialProperties:props];
		[uiManager setAvailableSize:CGSizeMake(375, 667) forRootView:self.toVC.view];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(pushAfterLoad:)
													 name: @"RCTContentDidAppearNotification"
												   object:nil];
	} else {
		[[vc navigationController] pushViewController:newTop animated:YES];
	}
	
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
