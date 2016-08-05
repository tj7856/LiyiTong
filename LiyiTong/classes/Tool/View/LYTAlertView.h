

#import <UIKit/UIKit.h>

@class LYTAlertView;

@protocol  LYTAlertViewDelegate<NSObject>
@optional
/**
 *  点击取消按钮
 */
- (void)clickedCancelBtn;

/**
 *  点击确定按钮
 */
- (void)clickedConfirmBtn:(LYTAlertView*)alertView;

- (void)alertView:(LYTAlertView *)alertView clickedButtonIndex:(NSInteger)buttonIndex;

@end

@interface LYTAlertView : UIView

/**
 *  弹框距离屏幕边缘的左右边距
 */
@property (nonatomic, assign) CGFloat leftRightPadding;

/**
 *  弹框内文字的左右边距
 */
@property (nonatomic, assign) CGFloat leftRightMargin;

/**
 *  弹框文字的上边距
 */
@property (nonatomic, assign) CGFloat topMargin;

/**
 *  弹框文字的下边距
 */
@property (nonatomic, assign) CGFloat bottomMargin;

/**
 *  弹框交互区域(确定/取消)的高度
 */
@property (nonatomic, assign) CGFloat interActHeight;

/**
 *  圆角
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 *  背景色
 */
@property (nonatomic, strong) UIColor *maskViewBgColor;

/**
 *  弹出框的背景色
 */
@property (nonatomic, strong) UIColor *mainAlertViewBgColor;

/**
 *  分割线背景色
 */
@property (nonatomic, strong) UIColor *sepViewBgColor;

/**
 *  弹出框文字颜色
 */
@property (nonatomic, strong) UIColor *msgTextColor;

/**
 *  取消按钮的文字颜色
 */
@property (nonatomic, strong) UIColor *cancelButtonTextColor;

/**
 *  确定按钮的文字颜色
 */
@property (nonatomic, strong) UIColor *confirmButtonTextColor;

/**
 *  弹出框文字的字体
 */
@property (nonatomic, strong) UIFont *msgTextFont;

/**
 *  交互按钮的字体
 */
@property (nonatomic, strong) UIFont *actionButtonsFont;

/**
 *  弹出框文字的行间距(默认为0)
 */
@property (nonatomic, assign) CGFloat lineSpacing;

/**
 * 弹出框文字的字间距(默认为0)
 */
@property (nonatomic, assign) CGFloat characterSpacing;

/**
 *  弹出框文字的对齐方式(默认为center)
 */
@property (nonatomic, assign) NSTextAlignment msgLabelTextAlignment;

@property (nonatomic, assign) id<LYTAlertViewDelegate>delegate;

/**
 *  弹框实例化
 *
 *  @param text      显示的文字
 *  @param cancelStr 取消按钮显示的文字,若为nil，则没有取消按钮
 *  @param confirmStr 确定按钮显示的文字,若为nil，则没有确定按钮
 *
 *  @return 实例
 */
- (instancetype)initWithText:(NSString *)text cancelButton:(NSString *)cancelStr confirmButton:(NSString *)confirmStr;

- (void)setMsgText:(NSString *)text cancelButton:(NSString *)cancelStr confirmButton:(NSString *)confirmStr;

/**
 *  显示弹框
 */
- (void)show;

/**
 *  显示弹框
 */
- (void)show:(UIView*)view;

- (void)addButtonWithTitle:(NSString *)title;

@end
