
import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(IconImage)
        IconImage.translatesAutoresizingMaskIntoConstraints = false
        IconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        IconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        IconImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        IconImage.heightAnchor.constraint(equalToConstant: 50).isActive = true

        UIView.animate(withDuration: 1.0, delay: 0.25, options: .curveEaseOut, animations: {
           
            self.IconImage.transform = CGAffineTransform(scaleX: 2.4, y: 2.4)
            
            
            
        }) { (err) in
            _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.ShowViewController2), userInfo: nil, repeats: false)
        }
        
        
    }
    @objc func ShowViewController2(){
        let controller = UINavigationController(rootViewController: HomeController())
        self.present(controller, animated: true, completion: nil)
    }
    let IconImage : UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "logo1")
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    



}

