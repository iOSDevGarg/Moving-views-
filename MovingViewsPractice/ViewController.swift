

//Transparency of image // moving object view
//jatin

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var newView: objectClass = objectClass()
    var constant: CGFloat = 0
    
    //outlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderViewBottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var image1Button: UIButton!
    @IBOutlet weak var image2Button: UIButton!
    @IBOutlet weak var image3Button: UIButton!
    @IBOutlet weak var sliderView: UIView!
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
     constant = self.sliderViewBottomLayoutConstraint.constant
    }

    //add a new object on current context
    @IBAction func objectAdded(theButton: UIButton!) {
        //set frame
        let frame = CGRect(x: 100, y: 100, width: 44, height: 44)
        newView = objectClass(frame: frame)
        //add new iimage according to button title
        if theButton.titleLabel?.text == "image1" {
        newView.image = UIImage(named: "1")
        } else if theButton.titleLabel?.text == "image2" {
            newView.image = UIImage(named: "2")
        }else{
            newView.image = UIImage(named: "3")
        }
        
        newView.contentMode = .scaleAspectFill
        newView.isUserInteractionEnabled = true
        self.view .addSubview(newView)
        
        //Animating new added image
        newView.alpha = 0
        UIView .animate(withDuration: 0.4) {
            self.newView.alpha = 1
        }

        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            self.sliderViewBottomLayoutConstraint.constant = self.sliderViewBottomLayoutConstraint.constant - self.sliderViewBottomLayoutConstraint.constant
            self.view.layoutIfNeeded()
        }, completion: nil)
    
        //Button disabled after adding a image till its value are not set
        image1Button.isEnabled = false
        image2Button.isEnabled = false
        image3Button.isEnabled = false
 
        //Adding gesture on clicked image
        let pinchGesture: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.recognizePinchGesture(sender:)))
        pinchGesture.delegate = self
        
        //rotation gesture
        let rotateGesture: UIRotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.recognizeRotateGesture(sender:)))
        //tap gesture
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.RemoveSelectedImageOnTap(sender:)))
        tapGesture.numberOfTapsRequired = 2
        //adding it to view
        self.newView.addGestureRecognizer(tapGesture)
        self.newView.addGestureRecognizer(pinchGesture)
        self.newView.addGestureRecognizer(rotateGesture)
    }
    
    //after setting sliders value
    @IBAction func DoneAction(_ sender: Any) {
        image1Button.isEnabled = true
        image2Button.isEnabled = true
        image3Button.isEnabled = true
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.sliderViewBottomLayoutConstraint.constant = CGFloat(self.constant)
             self.view.layoutIfNeeded()
        }, completion: nil)
    }
    //remove image on tap which is added at last
    func RemoveSelectedImageOnTap(sender: UITapGestureRecognizer) {
        self.newView .removeFromSuperview()
    }
    
    //recognizing gestures
    func recognizePinchGesture(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
    func recognizeRotateGesture(sender: UIRotationGestureRecognizer) {
        sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }

    @IBAction func sizeSlider(_ sender: UISlider) {
        slider.minimumValue = 0
        slider.maximumValue = 1
        self.newView.alpha = CGFloat(slider.value)
    }
}
