
import UIKit
import SCLAlertView
import SVProgressHUD
import Cosmos

extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    func dropShadow(cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0,height: 0.2)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UICollectionViewCell {
    
    func makeShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = 1.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true;
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0,height: 0.3)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
    }
}

extension SVProgressHUD {
   static func setupView(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
//        SVProgressHUD.setForegroundColor(UIColor.mainAppPink())
//        SVProgressHUD.setBackgroundColor(UIColor.darkGray.withAlphaComponent(0.6))
//        SVProgressHUD.setRingRadius(25)
//        SVProgressHUD.setRingThickness(5)
//        SVProgressHUD.setCornerRadius(25)
//        SVProgressHUD.setMinimumSize(CGSize(width: 30, height: 30))
   //     SVProgressHUD.show()
    }
}


extension UIViewController{
    
    func show1buttonAlert(title: String, message: String, buttonTitle: String, callback: @escaping () -> Void){
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "OneButtonAlertController") as! OneButtonAlertController
        controller.alertTitle = title
        controller.alertMessage = message
        controller.alertCancelButtonTitle = buttonTitle
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
    }
    
    func show2buttonAlert(title: String, message: String, cancelButtonTitle: String, defaultButtonTitle: String, callback: @escaping (_ defualt: Bool) -> ()) {
        
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TwoButtonAlertController") as! TwoButtonAlertController
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        controller.alertTitle = title
        controller.alertMessage = message
        controller.alertCancelButtonTitle = cancelButtonTitle
        controller.alertDefualtButtonTitle = defaultButtonTitle
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
//        controller.buttonAction = { defualt in
//          print(defualt)
//        }
    }
    
    func showRateAlert(callback: @escaping (_ valid: Bool,_ rate: Int) -> ()){
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RateAlertController") as! RateAlertController
        controller.providesPresentationContextTransitionStyle = true
        controller.definesPresentationContext = true
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
    }
    
    
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.none)
        }
    }
}



extension UIColor {
    static func mainAppPink() -> UIColor {
        return UIColor(hexString: "#FD6578")
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension Date {
    static func dateFromCustomString(customString: String) -> String {
        let time = Double(customString)
        let timeDate = NSDate(timeIntervalSince1970: time!)
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "dd MMM yyyy"
        return dateFormatterr.string(from: timeDate as Date)
    }
    static func dateFromCustomString2000(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    
    func reduceToMonthDayYear2000() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}




extension String {
    func IsValidString() -> Bool {
        if trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }else { return true }
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}
