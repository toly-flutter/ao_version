import Flutter
import UIKit
public class SwiftAoVersionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ao_version", binaryMessenger: registrar.messenger())
    let instance = SwiftAoVersionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

  }
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
    result("iOS " + UIDevice.current.systemVersion)
    case "toast":
       Toast.toast(text:"我在用Flutter调用iOS的方法",type:1)
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}


@objcMembers
class Toast: NSObject {
    var duration: CGFloat = 2.0
    var contentView: UIButton//内容框
    init(text: String) {
        let rect = text.boundingRect(
            with: CGSize(width: 250, height: CGFloat.greatestFiniteMagnitude),
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)],//该值可调节边距
            context: nil)
        let textLabel = UILabel(//标签
            frame: CGRect(x: 0, y: 0, width: rect.size.width + 40, height: rect.size.height + 20))
        textLabel.backgroundColor = UIColor.clear
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 16)
        textLabel.text = text
        textLabel.numberOfLines = 0
        contentView = UIButton(type: .roundedRect)
        contentView.frame=CGRect(x: 0, y: 0,
                                 width: textLabel.frame.size.width,
                                 height: textLabel.frame.size.height)
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        contentView.addSubview(textLabel)
        contentView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        super.init()
        contentView.addTarget(self, action: #selector(toastTaped), for: .touchDown)
    }
    func toastTaped() {
        self.hideAnimation()
    }

    func dismissToast() {
        contentView.removeFromSuperview()
    }
    func setDuration(duration: CGFloat) {
        self.duration = duration
    }

    func showAnimation() {
        UIView.beginAnimations("show", context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeIn)
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 1.0
        UIView.commitAnimations()
    }
     func hideAnimation() {
        UIView.beginAnimations("hide", context: nil)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeOut)
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(dismissToast))
        UIView.setAnimationDuration(0.3)
        contentView.alpha = 0.0
        UIView.commitAnimations()
    }

    func showFromBottomOffset(bottom: CGFloat) {
        let window: UIWindow = UIApplication.shared.windows.last!
        contentView.center = CGPoint(x: window.center.x, y: window.frame.size.height - (bottom + contentView.frame.size.height/2))
        window.addSubview(contentView)
        showAnimation()
        perform(#selector(hideAnimation), with: nil, afterDelay: TimeInterval(duration))
    }

    class func toast(text: String,type: Int) {
        let toast = Toast(text: text)
        var duration=0
        if type==0 {duration=1}else{duration=3}
        toast.setDuration(duration: CGFloat(duration))
        toast.showFromBottomOffset(bottom: 100)
    }
}