### 最近在研究视频播放在保持设备竖屏的情况下  横竖屏的问题 尝试过很多的方法
* 利用系统的横竖屏转换  通过控制控制器的 shouldAutorotate 和 supportedInterfaceOrientations 两个方法来切换横屏，但是这个在自定义转场动画的情况下不太灵活
* 在上一个的基础上 通过以下方法控制 在适当的地方调用这个方法去强制让设备横屏 这个是可以解决了视频横屏的问题，但是带来界面布局紊乱的bug 并且系统的旋转动画会显得不太自然
```
class func switchDevicesOrientation(orientation: UIDeviceOrientation){
    let resetOrientationTarget = UIInterfaceOrientation.unknown.rawValue
    UIDevice.current.setValue(resetOrientationTarget, forKey: "orientation")
    let orientationTarget = orientation.rawValue
    UIDevice.current.setValue(orientationTarget, forKey: "orientation")
}
```
* 于是通过研究梨视频和网易云，发现他们的实现应该是基于view的旋转，因为动画开始的时候，底部的视图并没有跟着旋转。 梨视频的会把状态栏也同样的给横过来，而网易云的不会  但是状态栏不横的话会有潜在问题 ，比如键盘适配，系统的音量 展示  都仍然是竖屏状态（前两种方式不会有这个问题） 经过研究，发现梨视频的是在view做旋转的基础上，又进一步控制了状态栏的朝向  核心代码   setStatusBarOrientation 这个方法只有在 supportedInterfaceOrientations返回值为0 的情况下生效  setStatusBarOrientation这个方法已经被弃用了，可能会有潜在问题，但是就目前来看 好多视频APP依旧在沿用这种方式

```
//把这个设置为 0  可令 setStatusBarOrientation 方法生效
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
    return UIInterfaceOrientationMask.init(rawValue: 0)
}

UIApplication.shared.setStatusBarOrientation(.landscapeRight, animated: true)

```


