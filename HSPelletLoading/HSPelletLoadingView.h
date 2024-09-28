//
//  HSPelletLoadingView.h
//  HSPelletLoading
//
//  Created by 123 on 2024/9/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HSHudMaskType) {
    HSHudMaskTypeClear,
    HSHudMaskTypeNone
};

@interface HSPelletLoadingView : UIView
/***显示加载（小球转圈）
 @param message 提示文本
 */
+ (void)showSuccessWithStatus:(NSString *)message maskType:(HSHudMaskType)maskType;

+ (void)dismiss;
@end

NS_ASSUME_NONNULL_END
