//
//  HSPelletLoadingView.m
//  HSPelletLoading
//
//  Created by 123 on 2024/9/27.
//

#import "HSPelletLoadingView.h"

@interface HSPelletLoadingView()


@end

@implementation HSPelletLoadingView

static UIView *overlayView;

+ (void)showSuccessWithStatus:(NSString *)message maskType:(HSHudMaskType)maskType {
    UIWindow *keyWindow = [self getKeyWindow];
    UIView *loadingView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    [keyWindow addSubview:loadingView];
    overlayView = loadingView;
    
    // 设置遮罩类型
    loadingView.userInteractionEnabled = (maskType == HSHudMaskTypeClear) ? YES : NO;
    loadingView.backgroundColor = [UIColor clearColor];

    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 164, 164)];
    mainView.center = CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height * 0.43);
    mainView.backgroundColor = [UIColor clearColor];
    [loadingView addSubview:mainView];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // 创建 UIVisualEffectView
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    blurEffectView.backgroundColor = [UIColor colorWithRed:95/255.0 green:80/255.0 blue:74/255.0 alpha:1.0];
    blurEffectView.backgroundColor = [[UIColor colorWithRed:51/255.0 green:47/255.0 blue:50/255.0 alpha:1] colorWithAlphaComponent:0.7];
    // 设置毛玻璃视图的初始尺寸，覆盖整个 cameraBtn
    blurEffectView.frame = mainView.bounds;
    blurEffectView.layer.cornerRadius = 16;
    blurEffectView.layer.masksToBounds = YES;
    // 默认隐藏
    blurEffectView.alpha = 1;
    
    [mainView addSubview:blurEffectView];
    
    // 创建加载气泡
    UIView *bubble = [[UIView alloc] initWithFrame:CGRectMake((mainView.frame.size.width - 50)/2, 40, 50, 50)];
    bubble.backgroundColor = [UIColor clearColor];
    bubble.layer.cornerRadius = bubble.frame.size.width/2;
    [mainView addSubview:bubble];

    // 添加小球动画
    CGFloat radius = bubble.frame.size.width / 2; // 半径
   NSArray *ballSizes = @[ @8, @9, @10, @11, @12, @13, @14, @7];

   for (int i = 0; i < ballSizes.count; i++) {
       CGFloat ballSize = [ballSizes[i] floatValue];
       UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ballSize, ballSize)];
       ball.backgroundColor = [UIColor whiteColor];
       ball.layer.cornerRadius = ballSize / 2;
       ball.hidden = YES;

       // 计算每个小球的位置
//       CGFloat angle = (2 * M_PI / ballSizes.count) * i; // 角度
//       radius = bubble.frame.size.width / 2 + (ballSize /2);
//       CGFloat x = CGRectGetWidth(bubble.frame)/2 + radius * cos(angle);
//       CGFloat y = CGRectGetHeight(bubble.frame)/2 + radius * sin(angle);
//       ball.center = CGPointMake(x, y);
       
       [bubble addSubview:ball];

       CGFloat duration = 1.5;
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * duration/8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           ball.hidden = NO;
       });

       
       // 创建旋转动画
         CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
         rotationAnimation.duration = duration;
         rotationAnimation.repeatCount = HUGE_VALF;
         rotationAnimation.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(bubble.frame.size.width/2, bubble.frame.size.height/2) radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES].CGPath;

         // 设置动画延迟
         rotationAnimation.beginTime = CACurrentMediaTime() + (i * duration/8); // 每个小球延迟0.2秒

         [ball.layer addAnimation:rotationAnimation forKey:nil];
   }

    // 添加文本标签
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, mainView.frame.size.height -  20 - 30, mainView.frame.size.width-16, 30)];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [mainView addSubview:label];
}

+ (void)dismiss{
    if (overlayView) {
        [overlayView removeFromSuperview]; // 移除视图
        overlayView = nil; // 清空引用
      }
}

+ (UIWindow *)getKeyWindow{
    
    UIWindow* keyWindow = nil;
    
    if (@available(iOS 13.0, *)) {
    // 获取所有连接的场景
    NSSet<UIScene *> *connectedScenes = [[UIApplication sharedApplication] connectedScenes];

    // 遍历场景集合
        for (UIScene *scene in connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *windowScene = (UIWindowScene *)scene;
                
                // 获取场景的窗口
                NSArray<UIWindow *> *windows = windowScene.windows;
                
                // 遍历窗口数组
                for (UIWindow *window in windows) {
                    if (window.isKeyWindow) {
                        // 找到具有键盘输入焦点的窗口
                        keyWindow = window;
                        break; // 找到后可以提前退出循环
                    }
                }
            }
        }
    } else {
        keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return keyWindow;
}


@end
