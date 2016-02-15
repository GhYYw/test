//
//  ViewController.m
//  shaperLayer
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.layer = [self shapeLayer:3];
    [self.view.layer addSublayer:_layer];
}

- (CAShapeLayer *) shapeLayer
{
    CGRect screenRc = [[UIScreen mainScreen] bounds];
    CGFloat oriX = screenRc.size.width/2 - 200/2;
    CGRect rc = CGRectMake(oriX, 100, 100, 100);
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = rc;
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [[UIColor blackColor] CGColor];
    UIBezierPath*path =  [UIBezierPath bezierPathWithRoundedRect:rc cornerRadius:50];
    layer.path = path.CGPath;
    
    return layer;
}

- (CAShapeLayer *)shapeLayerCurve
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.strokeColor = [[UIColor blackColor] CGColor];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 100)];
    [path addCurveToPoint:CGPointMake(310, 100) controlPoint1:CGPointMake(100, 50) controlPoint2:CGPointMake(200, 150)];
    layer.path = path.CGPath;
    
    return layer;
}

- (CAShapeLayer *) shapeLayerCube
{
    CGRect rc = [[UIScreen mainScreen] bounds];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [[UIColor redColor] CGColor];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, rc.size.height-80)];
    [path addLineToPoint:CGPointMake(0, rc.size.height)];
    [path addLineToPoint:CGPointMake(rc.size.width, rc.size.height)];
    [path addLineToPoint:CGPointMake(rc.size.width, rc.size.height-80)];
    [path addQuadCurveToPoint:CGPointMake(0, rc.size.height-80) controlPoint:CGPointMake(rc.size.width / 2, rc.size.height-80- 20)];
    
    shapeLayer.path = path.CGPath;
    return  shapeLayer;
    
}

- (CAShapeLayer *)shapeLayerCircle
{
    CAShapeLayer *ovalShapeLayer = [CAShapeLayer layer];
    ovalShapeLayer.strokeColor = [UIColor colorWithRed:0.984 green:0.153 blue:0.039 alpha:1.000].CGColor;
    ovalShapeLayer.fillColor = [UIColor clearColor].CGColor;
    ovalShapeLayer.lineWidth = 3;
    ovalShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 200,100, 100) cornerRadius:50].CGPath;
    
    return ovalShapeLayer;
}
- (CAShapeLayer *) shapeLayer:(int)stype
{
    switch (stype) {
        case 0:
            return [self shapeLayer];
        case 1:
            return [self shapeLayerCurve];
        case 2:
            return [self shapeLayerCube];
        case 3:
            return [self shapeLayerCircle];
        default:
            break;
    }
    
    return nil;
}

- (IBAction)butAction:(id)sender
{
    [self animation3:self.layer];
}

- (void) animation1:(CALayer *)layer
{
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAnimation.fromValue = @0;
    baseAnimation.toValue = @1;
    baseAnimation.duration = 2.0;
    [layer addAnimation:baseAnimation forKey:@""];
    
}

- (void) animation2:(CALayer *)layer
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)layer;
    shapeLayer.strokeStart = 0.5;
    shapeLayer.strokeEnd = 0.5;
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    baseAnimation.fromValue = @0.5;
    baseAnimation.toValue = @0;
    baseAnimation.duration = 2.0;
    
    CABasicAnimation *endAn = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    endAn.fromValue = @0.5;
    endAn.toValue = @1.0;
    endAn.duration = 2.0;
    [shapeLayer addAnimation:baseAnimation forKey:@""];
    [shapeLayer addAnimation:endAn forKey:@""];
    
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0;
}

- (void) animation3:(CALayer *)layer
{
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)layer;
    shapeLayer.strokeStart = 0;
    //shapeLayer.lineDashPattern = @[@6, @3];
    CABasicAnimation *animStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animStart.fromValue = @(-1);
    animStart.toValue = @1;
    
    CABasicAnimation *animEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animEnd.fromValue = @0;
    animEnd.toValue = @1.0;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animStart, animEnd];
    group.duration = 2;
    group.repeatCount = 10000;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [shapeLayer addAnimation:group forKey:@""];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
