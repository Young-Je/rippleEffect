//
//  UIView+RippleVIew.h
//  wifiBindingModule
//
//  Created by Hutong on 26/03/2018.
//  Copyright © 2018 Hutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RippleAnimationAvatarSize CGSizeMake(100, 100)
#define RippleAnimationExpandSizeValue 40.0
#define RippleAnimationDuration 2.0
#define RippleAnimationLineWidth 1.0

@interface UIView (RippleVIew)
+ (void)animationAvatarInView:(UIView *)view initPath:(UIBezierPath*)initPath finalPath:(UIBezierPath*)finalPath animated:(BOOL)animated;
+(void)stopRippleAnimation:(UIView *)view;
@end
