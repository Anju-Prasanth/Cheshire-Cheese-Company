//
//  FilterpageViewController.swift
//  CheshireCheeseCompany
//
//  Created by apple on 29/03/19.
//  Copyright © 2019 websight. All rights reserved.
//

import UIKit
import WARangeSlider

class FilterpageViewController: UIViewController {

    let rangeSlider1 = RangeSlider(frame: CGRect.zero)
    let rangeSlider2 = RangeSlider(frame: CGRect.zero)
    var upperprice=String()
    var lowerprice=Int()
    var productname=String()
    var categoryid=Int()
    
    @IBOutlet weak var lblmaxprice: UILabel!
    @IBOutlet weak var lblminprice: UILabel!
    
    @IBOutlet weak var btnapply: UIButton!
    @IBOutlet weak var backbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        rangeSlider2.trackHighlightTintColor = UIColor.red
//        rangeSlider2.curvaceousness = 0.0
        print("categoryid",categoryid)
        view.addSubview(rangeSlider1)
       // view.addSubview(rangeSlider2)
        rangeSlider1.lowerValue=lowerprice
        rangeSlider1.minimumValue=lowerprice
        rangeSlider1.maximumValue=Int(upperprice)!
        rangeSlider1.upperValue=Int(upperprice)!
        lblmaxprice.text="£"+upperprice
//        rangeSlider1.minimumValue=0
//        rangeSlider1.maximumValue=Double(upperprice)!
        rangeSlider1.addTarget(self, action: #selector(FilterpageViewController.rangeSliderValueChanged(_:)), for: .valueChanged)
        print("upperprice",upperprice)
        btnapply.layer.cornerRadius=5
        btnapply.layer.borderWidth=1
        let color = UIColor(red: 215 / 255.0, green: 124 / 255.0, blue: 3 / 255.0, alpha: 1.0)
        btnapply.layer.borderColor=color.cgColor
        
        backbtn.setBackgroundImage(UIImage(named: "back"), for: .normal)
        backbtn.frame = CGRect(x: 0, y: 0, width:30, height: 30)
        backbtn.backgroundColor = UIColor.clear
        backbtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backbtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        backbtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        
    }
    
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }

    
    
    @IBAction func btnapplyactn(_ sender: Any) {
        let filteredproducts = self.storyboard?.instantiateViewController (withIdentifier: "FilteredProductsViewController") as! FilteredProductsViewController
          filteredproducts.startprice=String(rangeSlider1.lowerValue)
          filteredproducts.endprice=String(rangeSlider1.upperValue)
         filteredproducts.filteredprdctname=productname
         filteredproducts.filtercategoryid=String(categoryid)
        self.present(filteredproducts,animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider1.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 100,
                                    width: width, height: 31.0)
        //rangeSlider2.frame = CGRect(x: margin + 20, y: 5 * margin + topLayoutGuide.length + 100,width: width - 40, height: 40)
    }
    
    @IBAction func backbtnactn(_ sender: Any) {
         performSegueToReturnBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        lblminprice.text="£"+String(rangeSlider1.lowerValue)
        lblmaxprice.text="£"+String(rangeSlider1.upperValue)
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
        
    }
    
}

extension FilterpageViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
        
    }

}



