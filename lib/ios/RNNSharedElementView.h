#import <UIKit/UIKit.h>

@interface RNNSharedElementView : UIView

@property (nonatomic, strong) NSString* elementId;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSNumber* interactive;
@property (nonatomic, strong) UIViewController* vc;
@property (nonatomic) CGPoint originalCenter;

@end
