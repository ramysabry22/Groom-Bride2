import UIKit
import Cosmos


class CustomTextView: UITextView {
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Comment"
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 0))
    }
    @objc func handleTextChange() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class CustomTextField2: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 40)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class CustomSearchTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}




class RateAlert: NSObject {
    func setupMenu(){
        guard let window = UIApplication.shared.keyWindow else { return }
        let bottomPadding = window.safeAreaInsets.bottom
        let topPadding = window.safeAreaInsets.top
        let viewHeight = window.frame.height-topPadding-bottomPadding
        
        window.addSubview(blackView)
        window.addSubview(mainView)
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        blackView.frame = window.frame
        blackView.alpha = 0
        mainView.backgroundColor = UIColor.white
        mainView.layer.cornerRadius = 10
        
        mainView.addSubview(exitButton)
        exitButton.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0), size: CGSize(width: 20, height: 20))
        
    }
    
    func show(){
        guard let window = UIApplication.shared.keyWindow else { return }
        let topPadding = window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        let viewHeight = window.frame.height-topPadding-bottomPadding
        let xPosition = (window.frame.width-270)/2
        let yPosition = (viewHeight-300)/2
    
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 1
            self.mainView.frame = CGRect(x: xPosition, y: yPosition, width: 270, height: 300)
            
            
        }, completion: nil)
    }
    
    @objc func hide(){
        guard let window = UIApplication.shared.keyWindow else { return }
        let topPadding = window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        let viewHeight = window.frame.height-topPadding-bottomPadding
       
    
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 0
            self.mainView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            
        }) { (finished) in
        }
    }
    
    
    // MARK:- component setup
/**********************************************************************************/
    let mainView = UIView()
    let blackView = UIView()
    
    let exitButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.frame.size = CGSize(width: 80, height: 100)
        button.setBackgroundImage(UIImage(named: "BackICON2777"), for: .normal)
        return button
    }()
    let rateButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.frame.size = CGSize(width: 80, height: 100)
        button.setTitle("Rate", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.mainAppPink(), for: .normal)
        return button
    }()
    let cancelButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.frame.size = CGSize(width: 80, height: 100)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        return button
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Name Label"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Name Label"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = UIColor.clear
        return label
    }()
    let leftView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#ECECEC")
        return iv
    }()
    let rightView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#ECECEC")
        return iv
    }()
    let lineView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor(hexString: "#ECECEC")
        return iv
    }()
  
}
