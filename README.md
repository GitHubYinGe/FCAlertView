# FCAlertView
封装的提示选择弹框, 简单好用 无依赖

使用时,直接把文件导入工程就可以 添加包含头文件

#里面主要的两个方法
    /**
     * title            头部名字
     * preferredStyle   弹出的样式
     * cancaelName      默认文字 "取消"
     * determineName    默认文字 "确定"
     * cancel           点击取消按钮
     * determine        点击确认按钮
     */
     + (void)FCAlertWithTitle:(NSString *)title
                       cancelName:(NSString *)cancaelName
                       determineName:(NSString *)determineName
                       preferredStyle:(FCAlertStyle)preferredStyle
                       cancel:(void(^)())cancel
                       determine:(void(^)())determine;
    /**
     *  默认样式 中间弹出
     * title            头部名字
     * cancaelName      默认文字 "取消"
     * determineName    默认文字 "确定"
     * setUpTextField   可以拿到textField,进行设置
     * cancel           点击取消按钮
     * determine        点击确认按钮
     */
     + (void)FCAlertAddTextFieldWithTitle:(NSString *)title
                        cancelName:(NSString *)cancelName
                        determineName:(NSString *)determineName
                        textFIeld:(void (^)(UITextField *textField))setUpTextField
                        cancel:(void(^)())cancel
                        determine:(void(^)())determine;
