
import UIKit
import Cosmos

class RateAlertController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var rateStarsView: CosmosView!
    @IBOutlet weak var alertView: UIView!
    
    var buttonAction: ((_ valid: Bool,_ rate: Int) -> ())?
    var finalRate: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.mainAppPink().cgColor
        
        rateStarsView.didFinishTouchingCosmos = { rating in
            self.finalRate = Int(rating)
            print(self.finalRate)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateView()
    }
    
    
    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 40
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 40
        })
    }
    @IBAction func RateButtonAction(_ sender: UIButton) {
        self.buttonAction?(true,finalRate)
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func CancelButtonAction(_ sender: UIButton) {
        self.buttonAction?(false,0)
        self.dismiss(animated: true) {
            
        }
    }
    

}
