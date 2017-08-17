#import "RNNNavigationOptions.h"
#import <React/RCTConvert.h>


@implementation RNNNavigationOptions

-(instancetype)init {
	return [self initWithDict:@{}];
}

-(instancetype)initWithDict:(NSDictionary *)navigationOptions {
	self = [super init];
	self.topBarBackgroundColor = [[navigationOptions objectForKey:@"topBar"] objectForKey:@"backgroundColor"];
	self.statusBarHidden = [navigationOptions objectForKey:@"statusBarHidden"];
	self.title = [navigationOptions objectForKey:@"title"];
	self.topBarTextColor = [navigationOptions objectForKey:@"topBarTextColor"];
	self.screenBackgroundColor = [navigationOptions objectForKey:@"screenBackgroundColor"];
	self.topBarTextFontFamily = [navigationOptions objectForKey:@"topBarTextFontFamily"];
	self.topBarHidden = [navigationOptions objectForKey:@"topBarHidden"];
	self.topBarHideOnScroll = [navigationOptions objectForKey:@"topBarHideOnScroll"];
	self.topBarButtonColor = [navigationOptions objectForKey:@"topBarButtonColor"];
	self.topBarTranslucent = [navigationOptions objectForKey:@"topBarTranslucent"];
	self.tabBadge = [navigationOptions objectForKey:@"tabBadge"];
	self.topBarTextFontSize = [navigationOptions objectForKey:@"topBarTextFontSize"];
	self.topBarTransparent = [navigationOptions objectForKey:@"topBarTransparent"];
	self.topBarTransparentTag = 78264803;
	
	return self;
}

-(void)mergeWith:(NSDictionary *)otherOptions {
	for (id key in otherOptions) {
		[self setValue:[otherOptions objectForKey:key] forKey:key];
	}
}

-(void)storeOriginalTopBarImages:(UIViewController*)viewController {
	NSMutableDictionary *originalTopBarImages = [@{} mutableCopy];
	UIImage *bgImage = [viewController.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
	if (bgImage != nil) {
		originalTopBarImages[@"backgroundImage"] = bgImage;
	}
	UIImage *shadowImage = viewController.navigationController.navigationBar.shadowImage;
	if (shadowImage != nil) {
		originalTopBarImages[@"shadowImage"] = shadowImage;
	}
	self.originalTopBarImages = originalTopBarImages;
}

-(void)applyOn:(UIViewController*)viewController {
	if (self.topBarBackgroundColor) {
		UIColor* topBarBackgroundColor = [RCTConvert UIColor:self.topBarBackgroundColor];
		viewController.navigationController.navigationBar.barTintColor = topBarBackgroundColor;
	} else {
		viewController.navigationController.navigationBar.barTintColor = nil;
	}
	
	if (self.title) {
		viewController.navigationItem.title = self.title;
	}
	
	if (self.topBarTextFontFamily || self.topBarTextColor || self.topBarTextFontSize){
		NSMutableDictionary* navigationBarTitleTextAttributes = [NSMutableDictionary new];
		if (self.topBarTextColor) {
			navigationBarTitleTextAttributes[NSForegroundColorAttributeName] = [RCTConvert UIColor:self.topBarTextColor];
		}
		if (self.topBarTextFontFamily){
			if(self.topBarTextFontSize) {
				navigationBarTitleTextAttributes[NSFontAttributeName] = [UIFont fontWithName:self.topBarTextFontFamily size:[self.topBarTextFontSize floatValue]];
			} else {
				navigationBarTitleTextAttributes[NSFontAttributeName] = [UIFont fontWithName:self.topBarTextFontFamily size:20];
			}
		} else if (self.topBarTextFontSize) {
			navigationBarTitleTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:[self.topBarTextFontSize floatValue]];
		}
		viewController.navigationController.navigationBar.titleTextAttributes = navigationBarTitleTextAttributes;
	}
	
	if (self.screenBackgroundColor) {
		UIColor* screenColor = [RCTConvert UIColor:self.screenBackgroundColor];
		viewController.view.backgroundColor = screenColor;
	}
	
	if (self.topBarHidden){
		if ([self.topBarHidden boolValue]) {
			[viewController.navigationController setNavigationBarHidden:YES animated:YES];
		} else {
			[viewController.navigationController setNavigationBarHidden:NO animated:YES];
		}
	}
	
	if (self.topBarHideOnScroll) {
		BOOL topBarHideOnScrollBool = [self.topBarHideOnScroll boolValue];
		if (topBarHideOnScrollBool) {
			viewController.navigationController.hidesBarsOnSwipe = YES;
		} else {
			viewController.navigationController.hidesBarsOnSwipe = NO;
		}
	}
	
	if (self.topBarButtonColor) {
		UIColor* buttonColor = [RCTConvert UIColor:self.topBarButtonColor];
		viewController.navigationController.navigationBar.tintColor = buttonColor;
	} else {
		viewController.navigationController.navigationBar.tintColor = nil;
	}
	
	if (self.tabBadge) {
		NSString *badge = [RCTConvert NSString:self.tabBadge];
		if (viewController.navigationController) {
			viewController.navigationController.tabBarItem.badgeValue = badge;
		} else {
			viewController.tabBarItem.badgeValue = badge;
<<<<<<< HEAD
		}
		
=======
	  }
>>>>>>> 12560f03e27e568ca0a84e3d6be3a57587de96e8
	}
	
	if (self.topBarTranslucent) {
		if ([self.topBarTranslucent boolValue]) {
			viewController.navigationController.navigationBar.translucent = YES;
		} else {
			viewController.navigationController.navigationBar.translucent = NO;
<<<<<<< HEAD
		}
		
	}
	
	void (^disableTopBarTransparent)() = ^void(){
		UIView *transparentView = [viewController.navigationController.navigationBar viewWithTag:self.topBarTransparentTag];
		if (transparentView){
			[transparentView removeFromSuperview];
			[viewController.navigationController.navigationBar setBackgroundImage:self.originalTopBarImages[@"backgroundImage"] forBarMetrics:UIBarMetricsDefault];
			viewController.navigationController.navigationBar.shadowImage = self.originalTopBarImages[@"shadowImage"];
			self.originalTopBarImages = nil;
		}
	};
	
	if (self.topBarTransparent) {
		if ([self.topBarTransparent boolValue]) {
			if (![viewController.navigationController.navigationBar viewWithTag:self.topBarTransparentTag]){
				[self storeOriginalTopBarImages:viewController];
				[viewController.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
				viewController.navigationController.navigationBar.shadowImage = [UIImage new];
				UIView *transparentView = [[UIView alloc] initWithFrame:CGRectZero];
				transparentView.tag = self.topBarTransparentTag;
				[viewController.navigationController.navigationBar insertSubview:transparentView atIndex:0];
			}
		} else {
			disableTopBarTransparent();
		}
	} else {
		disableTopBarTransparent();
=======
		}		
>>>>>>> 12560f03e27e568ca0a84e3d6be3a57587de96e8
	}
	
	
}
@end
