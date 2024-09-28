一个自定义的加载窗口，在主窗口上方显示，可以通过
typedef NS_ENUM(NSInteger, HSHudMaskType) {
    HSHudMaskTypeClear,
    HSHudMaskTypeNone
};
来区分是否需要拦截手势，HSHudMaskTypeClear为透明背景并且拦截手势，HSHudMaskTypeNone不拦截手势。

调用：
/***显示加载（小球转圈）
 @param message 提示文本
 */
+ (void)showSuccessWithStatus:(NSString *)message maskType:(HSHudMaskType)maskType;



/**
移除
*/
+ (void)dismiss;


效果：
![Simulator Screenshot - iPhone 12 - 2024-09-28 at 10 09 26](https://github.com/user-attachments/assets/b70d2195-fd0b-435f-b73b-73cff1e5045f)
