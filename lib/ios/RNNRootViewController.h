
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RNNLayoutNode.h"
#import "RNNRootViewCreator.h"
#import "RNNEventEmitter.h"
#import "RNNNavigationOptions.h"
#import "RNNAnimationController.h"
#import "RNNInteractiveAnimationController.h"
@interface RNNRootViewController : UIViewController	<UINavigationControllerDelegate>
@property (nonatomic, strong) RNNNavigationOptions* navigationOptions;
@property (nonatomic, strong) RNNAnimationController* animator;
-(instancetype)initWithName:(NSString*)name
				withOptions:(RNNNavigationOptions*)options
			withContainerId:(NSString*)containerId
			rootViewCreator:(id<RNNRootViewCreator>)creator
			   eventEmitter:(RNNEventEmitter*)eventEmitter;


@end
