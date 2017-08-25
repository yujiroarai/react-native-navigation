
#import <React/RCTViewManager.h>
#import "RNNSharedElement.h"

@interface RNNSharedElement()


@end
@implementation RNNSharedElement

RCT_EXPORT_MODULE();

RCT_CUSTOM_VIEW_PROPERTY(tag, NSNumber, RNNSharedElement)
{
	[view setValue:json forKeyPath:@"tag"];
}

- (UIView *)view
{
	UIView* sharedElement = [[UIView alloc] init];
	return sharedElement;
}

@end
