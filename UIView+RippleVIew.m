//
//  UIView+RippleVIew.m
//  wifiBindingModule
//
//  Created by Hutong on 26/03/2018.
//  Copyright © 2018 Hutong. All rights reserved.
//

#import "UIView+RippleVIew.h"
#import "QMUIKit.h"


@implementation UIView (RippleVIew)

+ (void)animationAvatarInView:(UIView *)view initPath:(UIBezierPath*)initPath finalPath:(UIBezierPath*)finalPath animated:(BOOL)animated {
    
    NSMutableArray *_layers = [[NSMutableArray alloc] init];
    NSInteger count = view.layer.sublayers.count;
    for (int i = 0; i < count; i++) {
        if ([view.layer.sublayers[i] isKindOfClass:[CAShapeLayer class]]) {
            [_layers addObject:view.layer.sublayers[i]];
            [view.layer.sublayers[i] setHidden:YES];
        }
    }
    count = _layers.count;
    for (int i = 0; i < count; i++) {
        [_layers[i] removeFromSuperlayer];
    }
    
    if (!animated) {
        return;
    }
    
    CAShapeLayer *layer1 = [self animationLayerWithPath:initPath];
    layer1.frame = CGRectMake(0, 0, RippleAnimationAvatarSize.width, RippleAnimationAvatarSize.height);
    [view.layer addSublayer:layer1];
    
    CAShapeLayer *layer2 = [self animationLayerWithPath:initPath];
    layer2.frame = layer1.frame;
    [view.layer addSublayer:layer2];
    
    CAShapeLayer *layer3 = [self animationLayerWithPath:initPath];
    layer3.frame = layer1.frame;
    [view.layer addSublayer:layer3];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (id)initPath.CGPath;
    pathAnimation.toValue = (id)finalPath.CGPath;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[pathAnimation, opacityAnimation];
    groupAnimation.duration = RippleAnimationDuration;
    groupAnimation.repeatCount = HUGE_VALF;
    
    [layer1 addAnimation:groupAnimation forKey:nil];
    groupAnimation.beginTime = CACurrentMediaTime() + RippleAnimationDuration / 3;
    [layer2 addAnimation:groupAnimation forKey:nil];
    groupAnimation.beginTime = CACurrentMediaTime() + 2 * RippleAnimationDuration / 3;
    [layer3 addAnimation:groupAnimation forKey:nil];
}

+(void)stopRippleAnimation:(UIView *)view{
    NSMutableArray *_layers = [[NSMutableArray alloc] init];
    NSInteger count = view.layer.sublayers.count;
    for (int i = 0; i < count; i++) {
        if ([view.layer.sublayers[i] isKindOfClass:[CAShapeLayer class]]) {
            [_layers addObject:view.layer.sublayers[i]];
            [view.layer.sublayers[i] setHidden:YES];
        }
    }
    count = _layers.count;
    for (int i = 0; i < count; i++) {
        [_layers[i] removeFromSuperlayer];
    }
}

+ (void)animationReplicatorAvatarInView:(UIView *)view initPath:(UIBezierPath*)initPath finalPath:(UIBezierPath*)finalPath  animated:(BOOL)animated {
    
    NSMutableArray *_layers = [[NSMutableArray alloc] init];
    NSInteger count = view.layer.sublayers.count;
    for (int i = 0; i < count; i++) {
        if ([view.layer.sublayers[i] isKindOfClass:[CAReplicatorLayer class]]) {
            [_layers addObject:view.layer.sublayers[i]];
            [view.layer.sublayers[i] setHidden:YES];
        }
    }
    count = _layers.count;
    for (int i = 0; i < count; i++) {
        [_layers[i] removeFromSuperlayer];
    }
    
    if (!animated) {
        return;
    }
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = RippleAnimationDuration / 3;
    replicatorLayer.backgroundColor = UIColorClear.CGColor;
    [view.layer addSublayer:replicatorLayer];
    
    CAShapeLayer *layer = [self animationLayerWithPath:initPath];
    layer.frame = CGRectMake(0, 0, RippleAnimationAvatarSize.width, RippleAnimationAvatarSize.height);
    [replicatorLayer addSublayer:layer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (id)initPath.CGPath;
    pathAnimation.toValue = (id)finalPath.CGPath;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[pathAnimation, opacityAnimation];
    groupAnimation.duration = RippleAnimationDuration;
    groupAnimation.repeatCount = HUGE_VALF;
    
    [layer addAnimation:groupAnimation forKey:nil];
}

+ (CAShapeLayer *)animationLayerWithPath:(UIBezierPath *)path {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = UIColorBlue.CGColor;
    layer.fillColor = UIColorClear.CGColor;
    layer.lineWidth = RippleAnimationLineWidth;
    return layer;
}

@end
