import UIKit

public struct JLToastDelay {
    public static let ShortDelay: NSTimeInterval = 2.0
    public static let LongDelay: NSTimeInterval = 3.5
}

@objc public class JLToast: NSOperation {
    
    public var view: JLToastView = JLToastView()
    
    public var text: String? {
        get {
            return self.view.textLabel.text
        }
        set {
            self.view.textLabel.text = newValue
        }
    }
    
    public var delay: NSTimeInterval = 0
    public var duration: NSTimeInterval = JLToastDelay.ShortDelay
    
    private var _executing = false
    override public var executing: Bool {
        get {
            return self._executing
        }
        set {
            self.willChangeValueForKey("isExecuting")
            self._executing = newValue
            self.didChangeValueForKey("isExecuting")
        }
    }
    
    private var _finished = false
    override public var finished: Bool {
        get {
            return self._finished
        }
        set {
            self.willChangeValueForKey("isFinished")
            self._finished = newValue
            self.didChangeValueForKey("isFinished")
        }
    }
    
    internal var window: UIWindow {
        let windows = UIApplication.sharedApplication().windows
        for window in windows.reverse() {
            let className = NSStringFromClass(window.dynamicType)
            if className == "UIRemoteKeyboardWindow" || className == "UITextEffectsWindow" {
                return window
            }
        }
        return windows.first!
    }
    
    
    public class func makeText(text: String) -> JLToast {
        return JLToast.makeText(text, delay: 0, duration: JLToastDelay.ShortDelay)
    }
    
    public class func makeText(text: String, duration: NSTimeInterval) -> JLToast {
        return JLToast.makeText(text, delay: 0, duration: duration)
    }
    
    public class func makeText(text: String, delay: NSTimeInterval, duration: NSTimeInterval) -> JLToast {
        let toast = JLToast()
        toast.text = text
        toast.delay = delay
        toast.duration = duration
        return toast
    }
    
    public func show() {
        JLToastCenter.defaultCenter().addToast(self)
    }
    
    override public func start() {
        if !NSThread.isMainThread() {
            dispatch_async(dispatch_get_main_queue(), {
                self.start()
            })
        } else {
            super.start()
        }
    }
    
    override public func main() {
        self.executing = true
        
        dispatch_async(dispatch_get_main_queue(), {
            self.view.updateView()
            self.view.alpha = 0
            self.window.addSubview(self.view)
            UIView.animateWithDuration(
                0.5,
                delay: self.delay,
                options: .BeginFromCurrentState,
                animations: {
                    self.view.alpha = 1
                },
                completion: { completed in
                    UIView.animateWithDuration(
                        self.duration,
                        animations: {
                            self.view.alpha = 1.0001
                        },
                        completion: { completed in
                            self.finish()
                            UIView.animateWithDuration(0.5, animations: {
                                self.view.alpha = 0
                            })
                        }
                    )
                }
            )
        })
    }
    
    public func finish() {
        self.executing = false
        self.finished = true
    }
    
}