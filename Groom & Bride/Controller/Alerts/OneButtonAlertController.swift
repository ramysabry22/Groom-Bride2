
import UIKit

class OneButtonAlertController: UIViewController {
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var alertTitle: String = "Error"
    var alertMessage: String = "Mahmoud eh da ya mahmoud hya nas btbosly kda leh, mahmoud eh da ya hoda hya nas de 3yza mny ana eh?"
    var alertCancelButtonTitle: String = "OK"
    var buttonAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateView()
    }
    func prepareData(){
        OkButton.setTitle(self.alertCancelButtonTitle, for: .normal)
        titleLabel.text = self.alertTitle
        msgTextView.text = self.alertMessage
        let alertHeight = estimateFrameForTitleText(self.alertMessage).height + 110
        heightConstraint.constant = alertHeight
        self.view.layoutIfNeeded()
    }
    
    @IBAction func OkButtonAction(_ sender: UIButton) {
        buttonAction?()
        self.dismiss(animated: true, completion: nil)
    }
    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 40
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 40
        })
    }
    
    
    
    // MARK : Text size
/*****************************************************************************************/
    fileprivate func estimateFrameForTitleText(_ text: String) -> CGRect {
        let width = 240
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 16)]), context: nil)
    }
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }
}
