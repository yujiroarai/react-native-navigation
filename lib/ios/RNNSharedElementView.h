//
//  RNNSharedElementView.h
//  ReactNativeNavigation
//
//  Created by Elad Bogomolny on 29/08/2017.
//  Copyright © 2017 Wix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RNNSharedElementView : UIView

@property (nonatomic, strong) NSString* elementId;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSNumber* interactive;
@property (nonatomic, strong) UIViewController* vc;
@property (nonatomic) CGPoint originalCenter;

@end
