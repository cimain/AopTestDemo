# AopTestDemo
AopTestDemo: iOS埋点统计方案: 1.Method Swizzling 2.AOP编程


## 场景需求

- 统计UIViewController加载次数
- 统计UIButton点击次数
- 统计自定义方法的执行
- 统计UITableView的Cell点击事件

工程说明，首页Test1ViewController，其中有4个按钮，点击第一个按钮打印，第二个到第四个按钮分别跳转到Test2ViewController，Test3ViewController，Test4ViewController。

> 技术选型：

- 复制统计的代码逻辑一个个地粘贴到需要统计的类和方法中去。工作量大，可维护性差，仅适用统计埋点极少的情况。
- 通过运行时Runtime的办法 -- 利用Method Swizzling机制进行方法替换：替换原来的需要在里面统计却不含统计逻辑的方法 为 新的包含了统计逻辑的方法。
- 通过AOP的方法 -- 利用Aspect框架对需要进行统计的方法进行挂钩（hook），并注入包含了统计逻辑的代码块（block）。


## 更多了解

简书地址：[iOS数据埋点统计方案(附Demo): 运行时Method Swizzling机制与AOP编程(面向切面编程)](https://www.jianshu.com/p/3ac8130b72eb)
