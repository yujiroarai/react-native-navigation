#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RNNSharedElementView.h"

@interface RNNAnimationController : NSObject <UIViewControllerAnimatedTransitioning>
-(void)setupTransition:(NSDictionary*)data;
-(CGRect)frameFromSuperView:(UIView*)view;
-(NSArray*)findRNNSharedElementViews:(UIView*)view;
-(RNNSharedElementView*)findViewToShare:(NSArray*)RNNSharedElementViews withId:(NSString*)elementId;

@end
